//
//  WarningCountAnalyzer.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-14.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class WarningAnalyzer: Analzyer {

    var warnings = [Warning]()

    init(logFile: [String]) {
        for line in logFile {
            if line.contains(LDWarning.lookFor) {
                warnings.append(LDWarning(description: line))
            } else if line.contains(FileWarning.lookFor) {
                warnings.append(FileWarning(firstLine: line))
            }
        }
    }

    func createReport() {

    }
}
