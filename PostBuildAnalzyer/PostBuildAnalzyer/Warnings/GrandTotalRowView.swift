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
    }
}
