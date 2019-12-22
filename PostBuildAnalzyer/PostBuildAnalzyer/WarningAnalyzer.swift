//
//  WarningCountAnalyzer.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-14.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class WarningAnalyzer: Analzyer {
    var symbol = "⚠️"
    var title = "Build Warnings"
    var developWarningCount: Int {
        return developWarnings.count
    }

    var prWarningCount: Int {
        return prWarnings.count
    }

    var developWarnings = [Warning]()
    var prWarnings = [Warning]()

    init(repoName: String, logFile: [String]) {
        var fileWarning: FileWarning?
        for line in logFile {
            if fileWarning != nil, line.starts(with: " ") {
                fileWarning?.add(line: line.trimSpaces())
            } else {
                fileWarning = nil
            }
            if line.contains(LDWarning.lookFor) {
                prWarnings.append(LDWarning(description: line))
            } else if line.contains(FileWarning.lookFor) {
                let newFileWarning = FileWarning(repoName: repoName, firstLine: line)
                prWarnings.append(newFileWarning)
                fileWarning = newFileWarning
            }
        }
    }

    func createNewReport() -> [String] {
        var result = [String]()
        for warning in prWarnings {
            result.append(warning.toHTML())
        }
        return result
    }
}
