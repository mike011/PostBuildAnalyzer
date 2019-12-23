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
    let symbol = "⏱"
    var detaledDescripiton = ""
    var measuredValue = ""

    let line: String
    var count: Int
    var description: String

    init(description: String) {
        self.line = description
        self.description = String(description.dropFirst(LDWarning.lookFor.count))
        self.count = 1
    }
}
