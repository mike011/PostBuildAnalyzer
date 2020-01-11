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

    var rows: [TableRowModel] {
        var result = [TableRowModel]()
        for warning in warnings {
            result.append(warning.value.view)
        }
        return result
    }

    var allWarnings: [WarningController] {
        return getWarningController()
    }

    var fileWarningController: [FileWarningController] {
        return getWarningController()
    }

    var linkerController: [LinkerWarningController] {
        return getWarningController()
    }

    var slowExpressions: [SlowExpressionController] {
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

    convenience init(args: Arguments) {
        var logFileName = args.outputFolder
        if args.outputFolder.last != "/" {
            logFileName += "/"
        }
        logFileName += args.logFileName
        let logFileContents = Utils.load(file: logFileName)
        self.init(
            repoURL: args.repoURL,
            branch: args.branch,
            buildTimeThresholdInMS: args.buildTimeThresholdInMS,
            logFile: logFileContents
        )
    }

    init(repoURL: String, branch: String, buildTimeThresholdInMS: Double, logFile: [String]) {
        for line in logFile {
            if let warning = warnings[line] {
                warning.addDuplicate()
            } else {
                if PostBuildAnalzyer.isSlowExpression(line: line, buildTimeThresholdInMS: buildTimeThresholdInMS) {
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
