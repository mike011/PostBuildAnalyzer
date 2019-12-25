//
//  Warning.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-24.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class WarningController: Hashable, Equatable {
    private var wp: WarningModel

    var count: Int = 0

    /// The line that is being parsed.
    var line: String

    init(line: String, wp: WarningModel) {
        self.line = line
        self.wp = wp
    }

    static func == (lhs: WarningController, rhs: WarningController) -> Bool {
        return lhs.line == rhs.line
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(line)
    }

    func toHTML() -> String {
        return wp.toHTML()
    }

    func getView() -> WarningView {
        let view = WarningView(data: wp)
        return view
    }
}
