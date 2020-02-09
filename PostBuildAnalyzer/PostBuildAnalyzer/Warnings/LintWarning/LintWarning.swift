//
//  LintWarning.swift
//  PostBuildAnalyzer
//
//  Created by Michael Charland on 2019-12-23.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class LintWarning: WarningModel {
    static var lookFor: String = ""

    var line = ""

    var description = ""

    var count = 1.0

    var symbol = ""

    var detailedDescripiton = ""

    var measuredValue = ""
}
