//
//  SlowExpressionTotalRowView.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-26.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class SlowExpressionTotalRowView: TotalRowView {
    var symbol = "⏱"

    var description: String {
        return "Files with compilation time >= \(buildTimeThresholdInMS)ms"
    }

    var before: [WarningController]

    var after: [WarningController]

    var buildTimeThresholdInMS: Double

    init(before: [WarningController], after: [WarningController], buildTimeThresholdInMS: Double) {
        self.before = before
        self.after = after
        self.buildTimeThresholdInMS = buildTimeThresholdInMS
    }
}
