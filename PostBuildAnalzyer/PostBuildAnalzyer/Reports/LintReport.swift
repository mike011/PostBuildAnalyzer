//
//  LintAnalyzer.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-14.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class LintReport: Report {
    var symbol = ""
    var title = ""
    var developWarningCount = 0
    var prWarningCount = 0

    func createNewReport() -> [String] {
        return [String]()
    }
}
