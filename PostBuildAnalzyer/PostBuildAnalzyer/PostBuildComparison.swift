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
    private var outputPath: String
    private var timeInMS: Double

    init?(arguments: [String]) {
        if arguments.count < 5 || arguments.count > 7 {
            print("Missing arguments \(arguments.count) found, expected the following: ")
            print("\t1 - The URL of the repo")
            print("\t2 - Output folder location")
            print("\t3 - PR Build log output file")
            print("\t4 - Develop Build log report file")
            print("\t5 - (Optional) PR SwiftLint html file location")
            print("\t6 - (Optional) Develop SwiftLint html file location")
            return nil
        }

        let repoURL = arguments[1]
        outputPath = arguments[2]
        let beforeLogFileName = arguments[3]
        let afterLogFileName = arguments[4]
        var beforeLintFileName: String?
        var afterLintFileName: String?
        if arguments.count > 6 {
            beforeLintFileName = arguments[5]
            afterLintFileName = arguments[6]
        }

        let beforeLogFile = Utils.load(file: beforeLogFileName)
        let beforeLintFile = Utils.load(file: beforeLintFileName)

        let afterLogFile = Utils.load(file: afterLogFileName)
        let afterLintFile = Utils.load(file: afterLintFileName)
        timeInMS = 100

        self.before = PostBuildAnalzyer(repoURL: repoURL, branch: "master", minimumTimeInMS: timeInMS, logFile: beforeLogFile, lintFile: beforeLintFile)
        self.after = PostBuildAnalzyer(repoURL: repoURL, branch: "develop", minimumTimeInMS: timeInMS, logFile: afterLogFile, lintFile: afterLintFile)
    }

    public func printTable() {
        print("<H3>New Warnings</H3>")
        print("")
        print("| |Description|Amount|")
        print("|:--:|---|:--:|")

        for row in after.rows.sorted() {
            print(row)
        }

        print("<BR>")
        print("<H3>Total Warnings</H3>")
        print("")
        print("| |📉|Description|Before|After|")
        print("|:-:|---|---|:---:|:--:|")

        print(SlowExpressionTotalRowView(before: before.slowExpressionController, after: after.slowExpressionController, timeInMS: timeInMS).getRow())
        print(FileWarningTotalRowView(before: before.fileWarningControler, after: after.fileWarningControler).getRow())
        print(LinkerWarningTotalRowView(before: before.linkerController, after: after.linkerController).getRow())

        print(GrandTotalRowView(before: before.allWarnings, after: after.allWarnings).getRow())
    }
}
