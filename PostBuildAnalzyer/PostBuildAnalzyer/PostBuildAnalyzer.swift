//
//  PostBuildAnalyzer.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-14.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class PostBuildAnalzyer {

    var analzyer = [Analzyer]()

    init(logFile: String, lintFile: String?) {
        analzyer.append(WarningCountAnalyzer(logFile: logFile))
        analzyer.append(SlowFilesAnalyzer(logFile: logFile))
        if let lintFile = lintFile {
            analzyer.append(LintAnalyzer(lintFile: lintFile))
        }
    }

    func createReports() {
        
    }

    func write() {
        
    }
}
