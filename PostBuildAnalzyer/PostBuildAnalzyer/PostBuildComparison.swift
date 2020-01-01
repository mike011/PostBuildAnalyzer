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

    init(before: Arguments, after: Arguments) {
        self.before = PostBuildAnalzyer(args: before)
        self.after = PostBuildAnalzyer(args: after)
        self.outputPath = URL(string: after.baseURLPath)!
        self.buildTimeThresholdInMS = before.buildTimeThresholdInMS
    }

    // init(before: PostBuildAnalzyer, after: PostBuildAnalzyer, baseURLPath: String, )

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

        lines.append("<H3>New Warnings</H3>")
        lines.append("")
        lines.append("| |Description|Amount|")
        lines.append("|:--:|---|:--:|")

        for row in after.rows.sorted() {
            lines.append(row)
        }
        return lines
    }

    func getTotalWarningsTable() -> [String] {
        var lines = [String]()

        lines.append("<BR>")
        lines.append("<H3>Total Warnings</H3>")
        lines.append("")
        lines.append("| |📉|Description|Before|After|")
        lines.append("|:-:|---|---|:---:|:--:|")

        lines.append(SlowExpressionTotalRowView(before: before.slowExpressionController, after: after.slowExpressionController, buildTimeThresholdInMS: buildTimeThresholdInMS).getRow())
        lines.append(FileWarningTotalRowView(before: before.fileWarningController, after: after.fileWarningController).getRow())
        lines.append(LinkerWarningTotalRowView(before: before.linkerController, after: after.linkerController).getRow())

        lines.append(GrandTotalRowView(before: before.allWarnings, after: after.allWarnings).getRow())
        return lines
    }
}
