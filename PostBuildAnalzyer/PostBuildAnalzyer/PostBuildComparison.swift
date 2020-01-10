//
//  PostBuildComparison.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-23.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

/// Compares 2 sets of analzyer data. For example the linting of two builds, slow expressions, and warnings.
class PostBuildComparsion {
    private let before: PostBuildAnalzyer
    private let after: PostBuildAnalzyer
    private var baseURL: URL
    private var buildTimeThresholdInMS: Double
    private var outputURL: URL

    convenience init(before: Arguments, after: Arguments) {
        let beforePBA = PostBuildAnalzyer(args: before)
        let afterPBA = PostBuildAnalzyer(args: after)
        self.init(
            before: beforePBA,
            after: afterPBA,
            baseURLPath: after.baseURLPath,
            buildTimeThresholdInMS: after.buildTimeThresholdInMS,
            outputFolder: after.outputFolder
        )
    }

    init(
        before: PostBuildAnalzyer,
        after: PostBuildAnalzyer,
        baseURLPath: String,
        buildTimeThresholdInMS: Double,
        outputFolder: String
    ) {
        self.before = before
        self.after = after
        self.baseURL = URL(string: baseURLPath)!
        self.buildTimeThresholdInMS = buildTimeThresholdInMS
        self.outputURL = URL(string: outputFolder)!
    }

    public func printTable() {
        for line in getNewWarningsTable().toHTML() {
            print(line)
        }
        print("<BR>")
        for line in getTotalWarningsTable() {
            print(line)
        }
    }

    func getNewWarningsTable() -> WebModel {
        let model = WebModel()

        var lines = [String]()
        guard !after.rows.isEmpty else {
            return model
        }

        model.addHeader(level: 3, title: "New Warnings")
        lines.append("<H3>New Warnings</H3>")
        lines.append("<BR>")
        for line in getWarningsTable(rows: after.rows) {
            lines.append(line)
        }
        return model
    }

    func getWarningsTable(rows: [String]) -> [String] {
        var lines = [String]()
        lines.append("| |Description|Amount|")
        lines.append("|:--:|---|:--:|")

        for row in rows.sorted() {
            lines.append(row)
        }
        return lines
    }

    func getTotalWarningsTable() -> [String] {
        var lines = [String]()

        let grandTotal = GrandTotalRowView(before: before.allWarnings, after: after.allWarnings)

        guard grandTotal.hasResults else {
            return lines
        }

        let wo = WebModel()
        wo.addHeader(level: 3, title: "Total Warnings")
        wo.addBlankLine()
        // TableHeader
        // let table = Table(headers: )
        //table.addHeader(titles: [" ", "📉", "Description", "Before", "After"])
        //table.set(alignment: [.Center, nil, nil, .Center, .Center])

        lines.append("<H3>Total Warnings</H3>")
        lines.append("")
        lines.append("| |📉|Description|Before|After|")
        lines.append("|:-:|---|---|:---:|:--:|")

        var rows = [TotalRowView]()
        rows.append(SlowExpressionTotalRowView(before: before.slowExpressions, after: after.slowExpressions, buildTimeThresholdInMS: buildTimeThresholdInMS))
        rows.append(FileWarningTotalRowView(before: before.fileWarningController, after: after.fileWarningController))
        rows.append(LinkerWarningTotalRowView(before: before.linkerController, after: after.linkerController))

        for row in rows {
            if row.hasResults {
                createHTMLFiles(row: row, outputURL: outputURL)
                lines.append(row.row(baseURL: baseURL))
            }
        }

        lines.append(grandTotal.row(baseURL: nil))
        return lines
    }

    func createHTMLFiles(row: TotalRowView, outputURL: URL) {
        let caller = String(describing: type(of: row.self))
        let beforeURL = URL(string: "file://\(outputURL.absoluteString)\(caller)_before.html")!
        let dataToSave = getWarningsTable(rows: before.rows)
        Utils.writeToFile(contents: dataToSave, url: beforeURL)

        let afterURL = URL(string: "file://\(outputURL.absoluteString)\(caller)_after.html")!
        let dataToSave2 = getWarningsTable(rows: after.rows)
        Utils.writeToFile(contents: dataToSave2, url: afterURL)
    }
}
