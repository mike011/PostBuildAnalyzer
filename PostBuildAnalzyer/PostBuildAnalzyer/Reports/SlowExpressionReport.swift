//
//  SlowExpressionAnalyzer.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-14.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class SlowExpressionReport: Report {
    var developWarningCount: Int = 0
    var prWarningCount: Int = 0

    var symbol = "⏱"
    let timeInMS: Int = 0
    var title: String {
        return "Expressions with compilation time >= \(timeInMS)ms"
    }

    var warnings = [Warning]()

    var warningCount: Int {
        var total = 0
        for warning in warnings {
            total += warning.count
        }
        return total
    }

//    init(timeInMS: Int, logFile: [String]) {
//        self.timeInMS = timeInMS
//
//        for line in logFile {
//            if let regex = try? NSRegularExpression(pattern: "\\d+\\.\\d{2}ms" + FileWarning.lookFor),
//                regex.matches(line) {
//                warnings.append(SlowExpression())
//            }
//        }
//    }

    func createNewReport() -> [String] {
        return [String]()
    }
}
