//
//  WarningAnalyzer.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-23.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class WarningAnalyzer: Analyzer {
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
                if var found = get(warning: newFileWarning, in: warnings) {
                    found.count += 1
                } else {
                    warnings.append(newFileWarning)
                }
                fileWarning = newFileWarning
            }
        }
    }

    func get(warning lookFor: Warning, in warnings: [Warning]) -> Warning? {
        for warning in warnings {
            if lookFor.line == warning.line {
                return warning
            }
        }
        return nil
    }
}
