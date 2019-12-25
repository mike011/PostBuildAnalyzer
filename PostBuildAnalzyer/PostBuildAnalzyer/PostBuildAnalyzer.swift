//
//  PostBuildAnalyzer.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-14.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class PostBuildAnalzyer {
    var warnings = Set<WarningController>()
    // var fileWarnings = Set<FileWarning>()
    // var lDWarnings = Set<LDWarning>()
    var slowExpressions = Set<SlowExpression>()

    var warningCount: Int {
        var warningCount = 0
        for warning in warnings {
            warningCount += warning.count
        }
//        for warning in lDWarnings {
//            warningCount += warning.count
//        }
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
        var warning: WarningController?
        for line in logFile {
            if let fileWarning = warning as? FileWarningController {
                if line.starts(with: " ") {
                    // fileWarning.wp.add
                    //  fileWarning.add(line: line.trimSpaces())
                } else {
                    warning = nil
                }
            }

            if PostBuildAnalzyer.isSlowExpression(line: line, minimumTimeInMS: minimumTimeInMS) {
                slowExpressions.insert(SlowExpression(line: line))
            } else if isLDWarning(line: line) {
                warnings.insert(LDWarningController(description: line))
            } else if isFileWarning(line: line) {
                warning = parseFileWarning(repoURL: repoURL, branch: branch, line: line)
            }
        }
    }

    private func parseFileWarning(repoURL: String, branch: String, line: String) -> WarningController {
        let newFileWarning = FileWarningController(repoURL: repoURL, branch: branch, firstLine: line)
        if let found = get(warning: newFileWarning, in: warnings) {
            found.count += 1
            return found
        } else {
            warnings.insert(newFileWarning)
            return newFileWarning
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
