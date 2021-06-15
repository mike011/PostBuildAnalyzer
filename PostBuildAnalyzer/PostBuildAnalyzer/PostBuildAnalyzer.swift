//
//  PostBuildAnalyzer.swift
//  PostBuildAnalyzer
//
//  Created by Michael Charland on 2019-12-14.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class PostBuildAnalyzer {
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
        var logFileName: String?
        if let fileName = args.logFileName {
            logFileName = folder + fileName
        }
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

    init(repoURL: String, branch: String, buildTimeThresholdInMS: Double?, logFile: [String], lintFile: [String]) {
        parseLogFile(repoURL: repoURL, branch: branch, buildTimeThresholdInMS: buildTimeThresholdInMS, logFile: logFile)
        parseLintFile(repoURL: repoURL, branch: branch, lintFile: lintFile)
        fillRows()
    }

    private func parseLogFile(repoURL: String, branch: String, buildTimeThresholdInMS: Double?, logFile: [String]) {
        for line in logFile {
            var warning: WarningController?
            if Self.isSlowExpression(line: line, buildTimeThresholdInMS: buildTimeThresholdInMS) {
                warning = SlowExpressionController(repoURL: repoURL, branch: branch, line: line)
            } else if Self.isLinkerWarning(line: line) {
                warning = LinkerWarningController(line: line)
            } else if Self.isFileWarning(line: line) {
                warning = FileWarningController(repoURL: repoURL, branch: branch, line: line)
            }
            if let warning = warning {
                if allWarnings.contains(warning) {
                    let wc = allWarnings.first { (wc) -> Bool in
                        return wc == warning
                    }
                    if let wc = wc {
                        wc.add(amount: warning.getTotalWarnings())
                    }
                } else {
                    allWarnings.append(warning)
                }
            }
        }
    }

    private func parseLintFile(repoURL: String, branch: String, lintFile: [String]) {
        var index = 0
        while index < lintFile.count {
            if Self.isLintWarning(line: lintFile[index]) {
                let warning = LintWarningController(
                    repoURL: repoURL,
                    branch: branch,
                    line: lintFile[index + 1],
                    file: lintFile[index - 2],
                    location: lintFile[index - 1]
                )
                if allWarnings.contains(warning) {
                    let wc = allWarnings.first { (wc) -> Bool in
                        return wc == warning
                    }
                    if let wc = wc {
                        wc.add(amount: warning.getTotalWarnings())
                    }
                } else {
                    allWarnings.append(warning)
                }
                index = index + 1
            }
            index = index + 1
        }
    }

    func fillRows() {
        for wc in allWarnings {
            wc.fillRow()
        }
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
