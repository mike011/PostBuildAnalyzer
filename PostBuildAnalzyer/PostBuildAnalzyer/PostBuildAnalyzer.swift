//
//  PostBuildAnalyzer.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-14.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class PostBuildAnalzyer {

    private var analzyer = [Analzyer]()

    init(logFile: [String], lintFile: [String]) {
        if !logFile.isEmpty {
            analzyer.append(WarningAnalyzer(logFile: logFile))
            analzyer.append(SlowFilesAnalyzer(logFile: logFile))
        }
        if !lintFile.isEmpty {
            analzyer.append(LintAnalyzer(lintFile: lintFile))
        }
    }

    func createReports() {
        
    }

    func write() {
        
    }
}
