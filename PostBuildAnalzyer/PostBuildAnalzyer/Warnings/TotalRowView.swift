//
//  TotalRowView.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-26.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

protocol TotalRowView {
    var symbol: String { get }
    var description: String { get }
    var before: [WarningController] { get set }
    var after: [WarningController] { get set }
}

extension TotalRowView {
    var change: String {
        var change = ""
        if before.count > after.count {
            change = "👍"
        } else if before.count < after.count {
            change = "👎"
        }
        return change
    }

    var row: String {
        // what if before and after are both zero
        return "|\(change)|\(symbol)|\(description)|\(before.count)|\(after.count)|"
    }

    var hasResults: Bool {
        return before.count > 0 || after.count > 0
    }
}
