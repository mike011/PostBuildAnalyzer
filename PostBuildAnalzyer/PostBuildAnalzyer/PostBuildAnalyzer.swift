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

    var warnings = [Warning]()

    var warningCount: Int {
        var warningCount = 0
        for warning in warnings {
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
                warnings.append(SlowExpression(line: line))
            } else if isFileWarning(line: line) {
                warning = parseFileWarning(repoURL: repoURL, branch: branch, line: line)
            } else if isLDWarning(line: line) {
                warnings.append(LDWarning(description: line))
            }
        }
    }

    private func parseFileWarning(repoURL: String, branch: String, line: String) -> Warning {
        let newFileWarning = FileWarning(repoURL: repoURL, branch: branch, firstLine: line)
        if var found = get(warning: newFileWarning, in: warnings) {
            found.count += 1
            return found
        } else {
            warnings.append(newFileWarning)
            return newFileWarning
        }
    }

    func get(warning lookFor: Warning, in warnings: [Warning]) -> Warning? {
        for warning in warnings {
            if lookFor.line == warning.line {
                return warning
            }
        }
        return nil
    }
}
