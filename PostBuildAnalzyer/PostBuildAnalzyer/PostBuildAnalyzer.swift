//
//  PostBuildAnalyzer.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-14.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class PostBuildAnalzyer {
    var warnings = [String: WarningController]()
    var slowExpressions = Set<SlowExpression>()

    var warningCount: Int {
        var warningCount = 0
        for warning in warnings {
            warningCount += warning.value.getTotalWarnings()
        }
        for warning in slowExpressions {
            warningCount += warning.count
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
            if PostBuildAnalzyer.isSlowExpression(line: line, minimumTimeInMS: minimumTimeInMS) {
                slowExpressions.insert(SlowExpression(line: line))
            } else if isLDWarning(line: line) {
                //       warnings.insert(LDWarningController(description: line))
            } else if isFileWarning(line: line) {
                parseFileWarning(repoURL: repoURL, branch: branch, line: line)
            }
        }
    }

    private func parseFileWarning(repoURL: String, branch: String, line: String) {
        if let warning = warnings[line] {
            warning.addDuplicate()
        } else {
            warnings[line] = FileWarningController(repoURL: repoURL, branch: branch, firstLine: line)
        }
    }

    func get(warning lookFor: WarningController, in warnings: Set<WarningController>) -> WarningController? {
        if warnings.contains(lookFor) {
            for warning in warnings {
                if warning == lookFor {
                    return warning
                }
            }
        }
        return nil
    }
}
