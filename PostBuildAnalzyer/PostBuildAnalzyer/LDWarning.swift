//
//  LDWarning.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-20.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class LDWarning: Warning {
    static let lookFor = "ld: warning: "

    var count: Int
    var description: String

    init(description: String) {
        self.description = String(description.dropFirst(LDWarning.lookFor.count))
        self.count = 1
    }

    func getFirstColumn() -> String {
        return "⏱"
    }

    func getSecondColumn() -> String {
        return ""
    }

    func getThirdColumn() -> String {
        return ""
    }
}
