//
//  PostBuildAnalyzer.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-14.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class PostBuildAnalzyer {
    var fileWarnings = Set<FileWarning>()
    var lDWarnings = Set<LDWarning>()
    var slowExpressions = Set<SlowExpression>()

    var warningCount: Int {
        var warningCount = 0
        for warning in fileWarnings {
            warningCount += warning.count
        }
        for warning in lDWarnings {
            warningCount += warning.count
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
        var warning: Warning?
        for line in logFile {
            if let fileWarning = warning as? FileWarning {
                if line.starts(with: " ") {
                    fileWarning.add(line: line.trimSpaces())
                } else {
                    warning = nil
                }
            }

            if PostBuildAnalzyer.isSlowExpression(line: line, minimumTimeInMS: minimumTimeInMS) {
                slowExpressions.insert(SlowExpression(line: line))
            } else if isLDWarning(line: line) {
                lDWarnings.insert(LDWarning(description: line))
            } else if isFileWarning(line: line) {
                warning = parseFileWarning(repoURL: repoURL, branch: branch, line: line)
            }
        }
    }

    private func parseFileWarning(repoURL: String, branch: String, line: String) -> Warning {
        let newFileWarning = FileWarning(repoURL: repoURL, branch: branch, firstLine: line)
        if var found = get(warning: newFileWarning, in: fileWarnings) {
            found.count += 1
            return found
        } else {
            fileWarnings.insert(newFileWarning)
            return newFileWarning
        }
    }

    func get(warning: FileWarning, in warnings: Set<FileWarning>) -> Warning? {
        if warnings.contains(warning) {
            for warning in warnings {
                if warning == warning {
                    return warning
                }
            }
        }
        return nil
    }
}
