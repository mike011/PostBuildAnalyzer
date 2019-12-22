//
//  Analyzer.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-14.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

protocol Analzyer {
    var symbol: String { get }
    var title: String { get }
    var developWarningCount: Int { get }
    var prWarningCount: Int { get }

    func createNewReport() -> [String]
}

extension Analzyer {
    func createOverallReport() -> String? {
        if developWarningCount == 0, developWarningCount == prWarningCount {
            return nil
        }
        var change = " "
        if developWarningCount > prWarningCount {
            change = "👍"
        } else if developWarningCount < prWarningCount {
            change = "👎"
        }
        return "|\(change)|\(symbol)|\(title)|\(developWarningCount)|\(prWarningCount)|"
    }
}
