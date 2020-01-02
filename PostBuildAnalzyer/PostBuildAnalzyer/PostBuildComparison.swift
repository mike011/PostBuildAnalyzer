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
    private var outputPath: URL
    private var buildTimeThresholdInMS: Double

    convenience init(before: Arguments, after: Arguments) {
        let beforePBA = PostBuildAnalzyer(args: before)
        let afterPBA = PostBuildAnalzyer(args: after)
        self.init(
            before: beforePBA,
            after: afterPBA,
            baseURLPath: after.baseURLPath,
            buildTimeThresholdInMS: after.buildTimeThresholdInMS
        )
    }

    init(before: PostBuildAnalzyer, after: PostBuildAnalzyer, baseURLPath: String, buildTimeThresholdInMS: Double) {
        self.before = before
        self.after = after
        self.outputPath = URL(string: baseURLPath)!
        self.buildTimeThresholdInMS = buildTimeThresholdInMS
    }

    public func printTable() {
        for line in getNewWarningsTable() {
            print(line)
        }
        for line in getTotalWarningsTable() {
            print(line)
        }
    }

    func getNewWarningsTable() -> [String] {
        var lines = [String]()
        guard !after.rows.isEmpty else {
            return lines
        }

        lines.append("<H3>New Warnings</H3>")
        lines.append("")
        lines.append("| |Description|Amount|")
        lines.append("|:--:|---|:--:|")

        for row in after.rows.sorted() {
            lines.append(row)
        }
        lines.append("<BR>")
        return lines
    }

    func getTotalWarningsTable() -> [String] {
        var lines = [String]()

        let grandTotal = GrandTotalRowView(before: before.allWarnings, after: after.allWarnings)

        guard grandTotal.hasResults else {
            return lines
        }

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
                lines.append(row.row(baseURL: outputPath))
            }
        }

        lines.append(grandTotal.row(baseURL: nil))
        return lines
    }
}
