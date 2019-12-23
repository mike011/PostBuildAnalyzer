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
    //  var reports = [Report]()

    init(repoName: String, timeInMS: Int, logFile: [String], lintFile: [String]) {
        if !logFile.isEmpty {
            analzyers.append(WarningAnalyzer(repoName: repoName, logFile: logFile))
            analzyers.append(SlowExpressionAnalyzer(timeInMS: timeInMS, logFile: logFile))
        }
        if !lintFile.isEmpty {
            analzyers.append(LintAnalzyer(lintFile: lintFile))
        }
    }

    func write(toLocation: String) {
//
//        for report in reports {
//            for html in report.createNewReport() {
//                print(html)
//            }
//        }
//
//
//        for report in reports {
//            if let html = report.createOverallReport() {
//                print(html)
//            }
//        }
    }

    func getWarnings() -> [Warning] {
        var warnings = [Warning]()
        for analyzer in analzyers {
            warnings += analyzer.warnings
        }
        return warnings
    }
}
