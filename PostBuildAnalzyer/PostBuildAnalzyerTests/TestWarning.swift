//
//  TestWarning.swift
//  PostBuildAnalzyerTests
//
//  Created by Michael Charland on 2019-12-22.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class TestWarning: Warning {
    var line: String
    var symbol = "Symbol"
    var detaledDescripiton = "Detailed Description"
    var measuredValue = "Measured Value"

    static var lookFor = "lookFor"
    var description = "description"
    var count = 1

    init(line: String = "line") {
        self.line = line
    }
}
