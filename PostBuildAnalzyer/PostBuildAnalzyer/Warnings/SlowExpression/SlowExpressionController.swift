//
//  SlowExpressionController.swift
//  PostBuildAnalzyer
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
}

extension PostBuildAnalzyer {
    static func isSlowExpression(line: String, buildTimeThresholdInMS: Double) -> Bool {
        if let regex = try? NSRegularExpression(pattern: "\\d+\\.\\d{2}ms") {
            return regex.matches(line) &&
                SlowExpressionModel.parseTimeInMS(line: line) > buildTimeThresholdInMS &&
                !line.contains("invalid loc")
        }
        return false
    }
}
