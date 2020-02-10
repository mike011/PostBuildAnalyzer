//
//  SlowExpressionController.swift
//  PostBuildAnalyzer
//
//  Created by Michael Charland on 2019-12-26.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class SlowExpressionController: WarningController {
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
        // 0.01ms    /Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/Warnings.swift:11:7    initializer init()
        return slowExpressionRegex.matches(line) &&
            SlowExpressionModel.parseTimeInMS(line: line) > buildTimeThresholdInMS &&
            !line.contains("invalid loc")
    }
}
