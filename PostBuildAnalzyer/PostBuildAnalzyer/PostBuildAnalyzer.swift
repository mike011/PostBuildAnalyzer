//
//  PostBuildAnalyzer.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-14.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class PostBuildAnalzyer {
    var allWarnings = [WarningController]()

    var rows: [TableRowModel] {
        var result = [TableRowModel]()
        for warning in allWarnings {
            result.append(warning.view)
        }
        return result
    }

    convenience init(args: Arguments) {
        var folder = args.outputFolder
        if args.outputFolder.last != "/" {
            folder += "/"
        }
        let logFileName = folder + args.logFileName
        let logFileContents = Utils.load(file: logFileName)
        let lintFileContents = Self.load(lintFile: args.lintFileName, folder: folder)

        self.init(
            repoURL: args.repoURL,
            branch: args.branch,
            buildTimeThresholdInMS: args.buildTimeThresholdInMS,
            logFile: logFileContents,
            lintFile: lintFileContents
        )
    }

    private class func load(lintFile file: String?, folder: String) -> [String] {
        guard let file = file else {
            return [String]()
        }
        return Utils.load(file: folder + file)
    }

    init(repoURL: String, branch: String, buildTimeThresholdInMS: Double, logFile: [String], lintFile: [String]) {
        parseLogFile(repoURL: repoURL, branch: branch, buildTimeThresholdInMS: buildTimeThresholdInMS, logFile: logFile)
        parseLintFile(repoURL: repoURL, branch: branch, buildTimeThresholdInMS: buildTimeThresholdInMS, lintFile: lintFile)
    }

    private func parseLogFile(repoURL: String, branch: String, buildTimeThresholdInMS: Double, logFile: [String]) {
        for line in logFile {
            var warning: WarningController?
            if PostBuildAnalzyer.isSlowExpression(line: line, buildTimeThresholdInMS: buildTimeThresholdInMS) {
                warning = SlowExpressionController(repoURL: repoURL, branch: branch, line: line)
            } else if isLinkerWarning(line: line) {
                warning = LinkerWarningController(line: line)
            } else if isFileWarning(line: line) {
                warning = FileWarningController(repoURL: repoURL, branch: branch, line: line)
            }
            if let warning = warning {
                if allWarnings.contains(warning) {
                    warning.add(amount: warning.getTotalWarnings())
                } else {
                    allWarnings.append(warning)
                }
            }
        }
    }

    private func parseLintFile(repoURL: String, branch: String, buildTimeThresholdInMS: Double, lintFile: [String]) {
        for line in lintFile {}
    }

    func getRows<T: WarningController>(forWarnings warnings: [T]) -> [TableRowModel] {
        var result = [TableRowModel]()
        for warning in warnings {
            result.append(warning.view)
        }
        return result
    }

    func getWarningController<T: WarningController>() -> [T] {
        var result = [T]()
        for warning in allWarnings {
            if let warning = warning as? T {
                result.append(warning)
            }
        }
        return result
    }
}
