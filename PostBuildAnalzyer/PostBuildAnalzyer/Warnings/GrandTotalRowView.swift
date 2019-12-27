//
//  GrandTotalRowView.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-26.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class GrandTotalRowView: TotalRowView {
    var symbol = ""

    var description = "Total Warnings"

    var before: [WarningController]

    var after: [WarningController]

    init(before: [WarningController], after: [WarningController]) {
        self.before = before
        self.after = after
        // self.before = before.fileWarningsCount + before.linkerCount + before.slowExpressionCount
        // self.after = after.fileWarningsCount + after.linkerCount + after.slowExpressionCount
    }
}
