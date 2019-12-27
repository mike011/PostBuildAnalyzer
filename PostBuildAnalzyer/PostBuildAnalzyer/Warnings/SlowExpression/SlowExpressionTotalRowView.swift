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
        return "Files with compilation time >= \(timeInMS)ms"
    }

    var before: [WarningController]

    var after: [WarningController]

    var timeInMS: Double

    init(before: [WarningController], after: [WarningController], timeInMS: Double) {
        self.before = before
        self.after = after
        self.timeInMS = timeInMS
    }
}
