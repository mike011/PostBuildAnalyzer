//
//  Warning.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-20.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

protocol Warning {
    static var lookFor: String { get }
    var line: String { get }
    var description: String { get }
    var count: Int { get set }

    var symbol: String { get }
    var detaledDescripiton: String { get }
    var measuredValue: String { get }
}

extension Warning {
    func toHTML() -> String {
        return "|\(symbol)|\(detaledDescripiton)|\(measuredValue)|"
    }
}
