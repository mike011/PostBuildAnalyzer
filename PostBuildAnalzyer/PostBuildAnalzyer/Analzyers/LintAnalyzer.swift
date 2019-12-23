//
//  LintAnalzyer.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-23.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class LintAnalzyer: Analyzer {
    var warnings: [Warning]

    init(lintFile: [String]) {
        self.warnings = [LintWarning]()
    }
}
