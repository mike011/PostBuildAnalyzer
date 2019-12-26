//
//  PostBuildAnalyzer.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-14.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

/// A container of different types of analysis done when a build has finished.
class PostBuildAnalzyer {
    var warnings = [String: WarningController]()

    var warningCount: Int {
        var warningCount = 0
        for warning in warnings {
            warningCount += warning.value.getTotalWarnings()
        }
        return warningCount
    }

    init(repoURL: String, branch: String, minimumTimeInMS: Double, logFile: [String], lintFile: [String]) {
        if !logFile.isEmpty {
            parseLogFile(repoURL: repoURL, branch: branch, minimumTimeInMS: minimumTimeInMS, logFile: logFile)
        }
        if !lintFile.isEmpty {}
    }

    private func parseLogFile(repoURL: String, branch: String, minimumTimeInMS: Double, logFile: [String]) {
        for line in logFile {
            if let warning = warnings[line] {
                warning.addDuplicate()
            } else {
                if PostBuildAnalzyer.isSlowExpression(line: line, minimumTimeInMS: minimumTimeInMS) {
                    warnings[line] = SlowExpressionController(repoURL: repoURL, branch: branch, line: line)
                } else if isLinkerWarning(line: line) {
                    warnings[line] = LinkerWarningController(line: line)
                } else if isFileWarning(line: line) {
                    warnings[line] = FileWarningController(repoURL: repoURL, branch: branch, line: line)
                }
            }
        }
    }
}
