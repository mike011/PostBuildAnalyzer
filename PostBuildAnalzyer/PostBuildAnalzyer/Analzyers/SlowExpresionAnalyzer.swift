//
//  SlowExpressionAnalyzer.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-23.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class SlowExpressionAnalyzer: Analyzer {
    var timeInMS: Int
    var warnings = [Warning]()

    var warningCount: Int {
        var total = 0
        for warning in warnings {
            total += warning.count
        }
        return total
    }

    init(timeInMS: Int, logFile: [String]) {
        self.timeInMS = timeInMS

        for line in logFile {
            if let regex = try? NSRegularExpression(pattern: "\\d+\\.\\d{2}ms" + FileWarning.lookFor),
                regex.matches(line) {
                warnings.append(SlowExpression())
            }
        }
    }
}
