//
//  LintWarningTotalRowView.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2020-02-06.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import Foundation

class LintWarningTotalRowView: TotalRowView {
    var symbol = "🧽"

    var description = "Lint Warnings"

    var before: [WarningController]

    var after: [WarningController]

    init(before: [WarningController], after: [WarningController]) {
        self.before = before
        self.after = after
    }
}
