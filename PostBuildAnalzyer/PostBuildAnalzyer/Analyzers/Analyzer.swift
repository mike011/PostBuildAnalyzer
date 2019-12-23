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
    private var change: String {
        var change = " "
        if developWarningCount > prWarningCount {
            change = "👍"
        } else if developWarningCount < prWarningCount {
            change = "👎"
        }
        return change
    }

    func createOverallReport() -> String? {
        if developWarningCount == 0, developWarningCount == prWarningCount {
            return nil
        }

        return "|\(change)|\(symbol)|\(title)|\(developWarningCount)|\(prWarningCount)|"
    }
}
