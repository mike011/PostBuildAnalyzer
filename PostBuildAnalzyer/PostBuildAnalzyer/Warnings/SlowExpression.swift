//
//  SlowExpression.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-23.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class SlowExpression: Warning {
    // not used, used regex instead.
    static var lookFor = ""

    var line: String = ""

    var description: String = ""

    var count: Int = 0

    var symbol: String = ""

    var detailedDescripiton: String = ""

    var measuredValue: String = ""
}
