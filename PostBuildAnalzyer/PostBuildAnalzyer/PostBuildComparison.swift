//
//  PostBuildComparison.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-23.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class PostBuildComparsion {
    private let before: PostBuildAnalzyer
    private let after: PostBuildAnalzyer
    private var outputPath: String

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
        let timeInMS = 100.0

        self.before = PostBuildAnalzyer(repoURL: repoURL, branch: "master", minimumTimeInMS: timeInMS, logFile: beforeLogFile, lintFile: beforeLintFile)
        self.after = PostBuildAnalzyer(repoURL: repoURL, branch: "pr", minimumTimeInMS: timeInMS, logFile: afterLogFile, lintFile: afterLintFile)
    }

    private var change: String {
        var change = " "
        if before.warningCount > after.warningCount {
            change = "👍"
        } else if before.warningCount < after.warningCount {
            change = "👎"
        }
        return change
    }

    public func printTable() {
        print("<H3>New Warnings</H3>")
        print("| |Description|Amount|")
        print("|:-:|---|:-:|")
        for warning in after.warnings {
            print(warning.toHTML())
        }
        let compare = "Before: \(before.warningCount) <br> After: \(after.warningCount)"
        print("|\(change)| Overall Warnings|\(compare)|")
    }
}
