//
//  LintWarning.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-23.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class LintWarning: WarningDetailsProtocol {
    static var lookFor: String = ""

    var line: String = ""

    var description: String = ""

    var count: Int = 0

    var symbol: String = ""

    var detailedDescripiton: String = ""

    var measuredValue: String = ""
}
