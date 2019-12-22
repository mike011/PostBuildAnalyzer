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

    init(repoName: String, logFile: [String], lintFile: [String]) {
        if !logFile.isEmpty {
            analzyers.append(WarningAnalyzer(repoName: repoName, logFile: logFile))
            analzyers.append(SlowFilesAnalyzer(logFile: logFile))
        }
        if !lintFile.isEmpty {
            analzyers.append(LintAnalyzer(lintFile: lintFile))
        }
    }

    func createReports() {
        for analzyer in analzyers {
            reports += analzyer.createNewReport()
        }
    }

    func write(toLocation: String) {
        print("<H3>New Warnings</H3>")
        print("| |Name|Amount|")
        print("|:-:|---|:-:|")
        for line in reports {
            print(line)
        }

        print("<H3>Overall Warnings</H3>")
        print("||📉|Warning|Master|PR|")
        print("|:-:|:-:|---|:-:|:-:|")
        for analzyer in analzyers {
            if let report = analzyer.createOverallReport() {
                print(report)
            }
        }
    }
}
