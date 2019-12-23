//
//  SlowExpressionAnalyzer.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-14.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class SlowExpressionAnalyzer: Analzyer {
    var symbol = "⏱"
    var title: String {
        return "Expressions with compilation time >= \(timeInMS)ms"
    }

    var developWarningCount = 0
    var prWarningCount = 0
    let timeInMS: Int

    init(timeInMS: Int, logFile: [String]) {
        self.timeInMS = timeInMS

        var fileWarning: FileWarning?
        for line in logFile {
            if let regex = try? NSRegularExpression(pattern: "\\d+\\.\\d{2}ms" + FileWarning.lookFor),
                regex.matches(line) {}
        }
    }

    func createNewReport() -> [String] {
        return [String]()
    }
}
