//
//  PostBuildComparison.swift
//  PostBuildAnalyzer
//
//  Created by Michael Charland on 2019-12-23.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

/// Compares 2 sets of analzyer data. For example the linting of two builds, slow expressions, and warnings.
class PostBuildComparsion {
    private let before: PostBuildAnalyzer
    private let after: PostBuildAnalyzer
    private var baseURL: URL
    private var buildTimeThresholdInMS: Double
    private var outputURL: URL

    convenience init(before: Arguments, after: Arguments) {
        let beforePBA = PostBuildAnalyzer(args: before)
        let afterPBA = PostBuildAnalyzer(args: after)
        self.init(
            before: beforePBA,
            after: afterPBA,
            baseURLPath: after.baseURLPath,
            buildTimeThresholdInMS: after.buildTimeThresholdInMS,
            outputFolder: after.outputFolder
        )
    }

    init(
        before: PostBuildAnalyzer,
        after: PostBuildAnalyzer,
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
        for line in getNewWarningsTable().toMarkdown() {
            print(line)
        }
        for line in getFixedWarningsTable().toMarkdown() {
            print(line)
        }
        for line in getTotalWarningsTable().toMarkdown() {
            print(line)
        }

        let reportURL = URL(fileURLWithPath: "\(outputURL.absoluteString)report.html")
        var html = getNewWarningsTable().toHTML()
        html += getFixedWarningsTable().toHTML()
        html += getTotalWarningsTable().toHTML()
        Utils.writeToFile(contents: html, url: reportURL)
    }

    func getNewWarningsTable() -> WebModel {
        return getWarningsTable(withTitle: "New Warnings", warnings: getNewWarnings())
    }

    func getFixedWarningsTable() -> WebModel {
        return getWarningsTable(withTitle: "Fixed Warnings", warnings: getFixedWarnings())
    }

    func getWarningsTable(withTitle: String, warnings: [TableRowModel]) -> WebModel {
        let model = WebModel()

        guard !warnings.isEmpty else {
            return model
        }

        model.addHeader(level: 3, title: withTitle)
        model.addBlankLine()
        model.add(webModel: getWarningsTable(rows: warnings))
        return model
    }

    func getNewWarnings() -> [TableRowModel] {
        var warnings = [TableRowModel]()
        for afterW in after.allWarnings {
            var found = false
            for beforeW in before.allWarnings {
                if afterW.model.description == beforeW.model.description {
                    found = true
                    break
                }
            }
            if !found {
                warnings.append(afterW.view)
            }
        }
        return warnings
    }

    func getFixedWarnings() -> [TableRowModel] {
        var warnings = [TableRowModel]()
        for beforeW in before.allWarnings {
            var found = false
            for afterW in after.allWarnings {
                if beforeW.model.description == afterW.model.description {
                    found = true
                    break
                }
            }
            if !found {
                warnings.append(beforeW.view)
            }
        }
        return warnings
    }

    func getWarningsTable(rows: [TableRowModel]) -> WebModel {
        let webModel = WebModel()

        let diff = TableHeader(title: "  ", alignment: .Center)
        let description = TableHeader(title: "Description", alignment: nil)
        let amount = TableHeader(title: "Amount", alignment: .Center)
        let table = Table(headers: [diff, description, amount])
        for row in rows { // }.sorted() {
            table.add(row: row)
        }
        webModel.add(table: table)

        return webModel
    }

    func getTotalWarningsTable() -> WebModel {
        let wo = WebModel()

        let grandTotal = GrandTotalRowView(before: before.getWarningController(), after: after.getWarningController())

        guard grandTotal.hasResults else {
            return wo
        }

        wo.addHeader(level: 3, title: "Total Warnings")
        wo.addBlankLine()

        let diff = TableHeader(title: "  ", alignment: .Center)
        let category = TableHeader(title: "📉", alignment: nil)
        let description = TableHeader(title: "Description", alignment: nil)
        let beforeHeader = TableHeader(title: "Before", alignment: .Center)
        let afterHeader = TableHeader(title: "After", alignment: .Center)
        let table = Table(headers: [diff, category, description, beforeHeader, afterHeader])

        var rows = [TotalRowView]()
        let bse = before.getWarningController() as [SlowExpressionController]
        let ase = after.getWarningController() as [SlowExpressionController]
        rows.append(SlowExpressionTotalRowView(before: bse, after: ase, buildTimeThresholdInMS: buildTimeThresholdInMS))

        let bfw = before.getWarningController() as [FileWarningController]
        let afw = after.getWarningController() as [FileWarningController]
        rows.append(FileWarningTotalRowView(before: bfw, after: afw))

        let blc = before.getWarningController() as [LinkerWarningController]
        let alc = after.getWarningController() as [LinkerWarningController]
        rows.append(LinkerWarningTotalRowView(before: blc, after: alc))

        let blwc = before.getWarningController() as [LintWarningController]
        let alwc = after.getWarningController() as [LintWarningController]
        rows.append(LintWarningTotalRowView(before: blwc, after: alwc))

        for row in rows {
            if row.hasResults {
                createHTMLFiles(row: row, outputURL: outputURL)
                table.add(row: row.row(baseURL: baseURL))
            }
        }
        table.add(row: grandTotal.row(baseURL: nil))

        wo.add(table: table)
        return wo
    }

    func createHTMLFiles(row: TotalRowView, outputURL: URL) {
        let caller = String(describing: type(of: row.self))
        let beforeURL = URL(fileURLWithPath: "\(outputURL.absoluteString)\(caller)_before.html")
        let dataToSave = getWarningsTable(rows: before.getRows(forWarnings: row.before)).toHTML()
        Utils.writeToFile(contents: dataToSave, url: beforeURL)

        let afterURL = URL(fileURLWithPath: "\(outputURL.absoluteString)\(caller)_after.html")
        let dataToSave2 = getWarningsTable(rows: after.getRows(forWarnings: row.after)).toHTML()
        Utils.writeToFile(contents: dataToSave2, url: afterURL)
    }
}
