//
//  PostBuildAnalyzer.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-14.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class PostBuildAnalzyer {

    private var analzyers = [Analzyer]()
    var reports = [String]()

    init(logFile: [String], lintFile: [String]) {
        if !logFile.isEmpty {
            analzyers.append(WarningAnalyzer(logFile: logFile))
            analzyers.append(SlowFilesAnalyzer(logFile: logFile))
        }
        if !lintFile.isEmpty {
            analzyers.append(LintAnalyzer(lintFile: lintFile))
        }
    }

    func createReports() {
        for analzyer in analzyers {
            reports += analzyer.createReport()
        }
    }

    func write() {
        
    }
}
