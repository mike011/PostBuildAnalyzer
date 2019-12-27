//
//  PostBuildAnalyzer.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-14.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class PostBuildAnalzyer {
    private var warnings = [String: WarningController]()

    var rows: [String] {
        var result = [String]()
        for warning in warnings {
            result.append(warning.value.printView())
        }
        return result
    }

    var allWarnings: [WarningController] {
        return getWarningController()
    }

    var fileWarningControler: [FileWarningController] {
        return getWarningController()
    }

    var linkerController: [LinkerWarningController] {
        return getWarningController()
    }

    var slowExpressionController: [SlowExpressionController] {
        return getWarningController()
    }

    func getWarningController<T: WarningController>() -> [T] {
        var result = [T]()
        for warning in warnings {
            if let warning = warning.value as? T {
                result.append(warning)
            }
        }
        return result
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
