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

    init(repoName: String, logFile: [String]) {
        var fileWarning: FileWarning?
        for line in logFile {
            if fileWarning != nil, line.starts(with: " ") {
                fileWarning?.add(line: line.trimSpaces())
            } else {
                fileWarning = nil
            }
            if line.contains(LDWarning.lookFor) {
                warnings.append(LDWarning(description: line))
            } else if line.contains(FileWarning.lookFor) {
                let newFileWarning = FileWarning(repoName: repoName, firstLine: line)
                warnings.append(newFileWarning)
                fileWarning = newFileWarning
            }
        }
    }

    func createReport() -> [String] {
        var result = [String]()
        for warning in warnings {
            result.append(warning.toHTML())
        }
        return result
    }
}
