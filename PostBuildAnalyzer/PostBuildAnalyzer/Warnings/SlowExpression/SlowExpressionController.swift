//
//  SlowExpressionController.swift
//  PostBuildAnalyzer
//
//  Created by Michael Charland on 2019-12-26.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class SlowExpressionController: WarningController {
    static let invalidLocation = "invalid loc"
    static let slowCompileFile = "expression took"

    init(repoURL: String, branch: String, line: String) {
        let model = SlowExpressionModel(repoURL: repoURL, branch: branch, line: line)
        let view = SlowExpressionView()
        super.init(model: model, view: view)
    }

    override func getTotalWarnings() -> Double {
        guard let model = model as? SlowExpressionModel else {
            return 0.0
        }
        return model.timeInMS
    }

    override func add(amount: Double) {
        guard let model = model as? SlowExpressionModel else {
            return
        }
        model.timeInMS += amount
    }
}

extension PostBuildAnalyzer {
    static let slowExpressionRegex = try! NSRegularExpression(pattern: "\\d+\\.\\d{2}ms")

    static func isSlowExpression(line: String, buildTimeThresholdInMS: Double) -> Bool {
        return isTimingSummary(line: line, thresholdInMS: buildTimeThresholdInMS)
            || isWarning(line: line)
    }

    private static func isTimingSummary(line: String, thresholdInMS: Double) -> Bool {
        return slowExpressionRegex.matches(line) &&
            SlowExpressionModel.parseTimeInMS(line: line) > thresholdInMS &&
            !line.contains(SlowExpressionController.invalidLocation)
    }

    private static func isWarning(line: String) -> Bool {
        return line.contains(FileWarningModel.lookFor) &&
            line.contains(SlowExpressionController.slowCompileFile)
    }
}
