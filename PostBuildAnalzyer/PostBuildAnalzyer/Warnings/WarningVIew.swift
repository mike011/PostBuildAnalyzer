//
//  WarningVIew.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-25.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

protocol WarningView: TableRowModel {
    var symbol: String { get }
    func getDetailedDescription(model: WarningModel) -> String
    func getMeasuredValue(model: WarningModel) -> String
    mutating func fillRow(model: WarningModel)
}

extension WarningView {
    mutating func fillRow(model: WarningModel) {
        columns.append(symbol)
        columns.append(getDetailedDescription(model: model))
        columns.append(getMeasuredValue(model: model))
    }
}
