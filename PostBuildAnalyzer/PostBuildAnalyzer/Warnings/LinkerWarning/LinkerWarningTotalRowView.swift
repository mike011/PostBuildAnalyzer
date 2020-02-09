//
//  LinkerWarningTotalRowView.swift
//  PostBuildAnalyzer
//
//  Created by Michael Charland on 2019-12-26.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class LinkerWarningTotalRowView: TotalRowView {
    var symbol = "🚨"

    var description = "Linker Warnings"

    var before: [WarningController]

    var after: [WarningController]

    init(before: [WarningController], after: [WarningController]) {
        self.before = before
        self.after = after
    }
}
