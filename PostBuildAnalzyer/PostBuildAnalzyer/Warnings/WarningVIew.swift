//
//  WarningVIew.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-25.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

protocol WarningView {
    var symbol: String { get }
    func getDetailedDescription(model: WarningModel) -> String
    func getMeasuredValue(model: WarningModel) -> String

    @discardableResult
    func printRow(model: WarningModel) -> String
}

extension WarningView {
    func printRow(model: WarningModel) -> String {
        let row = "|\(symbol)|\(getDetailedDescription(model: model))|\(getMeasuredValue(model: model))|"
        print(row)
        return row
    }
}
