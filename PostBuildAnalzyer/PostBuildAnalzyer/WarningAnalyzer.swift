//
//  WarningCountAnalyzer.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-14.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class WarningAnalyzer: Analzyer {

    var warnings = [String]()

    init(logFile: [String]) {
        for line in logFile {
            if line.contains(": warning: ") {
                warnings.append(line)
            }
        }
    }

    func createReport() {

    }
}
