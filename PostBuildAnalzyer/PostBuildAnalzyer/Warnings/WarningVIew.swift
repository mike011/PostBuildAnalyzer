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
    func printRow(model: WarningModel)
}

extension WarningView {
    func printRow(model: WarningModel) {
        print("|\(symbol)|\(getDetailedDescription(model: model))|\(getMeasuredValue(model: model))|")
    }
}
