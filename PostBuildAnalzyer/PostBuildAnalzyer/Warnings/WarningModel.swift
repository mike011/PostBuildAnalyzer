//
//  Warning.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-20.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

protocol WarningModel {
    static var lookFor: String { get }
    var line: String { get }
    var description: String { get }
    var count: Int { get set }

    var symbol: String { get }
    var detailedDescripiton: String { get }
    var measuredValue: String { get }
}

extension WarningModel {
    func toHTML() -> String {
        return "|\(symbol)|\(detailedDescripiton)|\(measuredValue)|"
    }
}
