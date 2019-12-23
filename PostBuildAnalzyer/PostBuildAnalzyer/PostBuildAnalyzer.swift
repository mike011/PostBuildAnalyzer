//
//  PostBuildAnalyzer.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-14.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class PostBuildAnalzyer {
    private var analzyers = [Analyzer]()
    var warnings: [Warning] {
        var warnings = [Warning]()
        for analyzer in analzyers {
            warnings += analyzer.warnings
        }
        return warnings
    }

    var warningCount: Int {
        var warningCount = 0
        for warning in warnings {
            warningCount += warning.count
        }
        return warningCount
    }

    init(repoURL: String, branch: String, timeInMS: Int, logFile: [String], lintFile: [String]) {
        if !logFile.isEmpty {
            analzyers.append(WarningAnalyzer(repoURL: repoURL, branch: branch, logFile: logFile))
            analzyers.append(SlowExpressionAnalyzer(timeInMS: timeInMS, logFile: logFile))
        }
        if !lintFile.isEmpty {
            analzyers.append(LintAnalzyer(lintFile: lintFile))
        }
    }
}
