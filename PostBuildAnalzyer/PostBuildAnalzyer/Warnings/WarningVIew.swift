//
//  WarningVIew.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-25.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

protocol WarningView {
    func printRow(model: WarningModel)
}

extension WarningView {
    func printRow(model: WarningModel) {
        print("|\(model.symbol)|\(model.detailedDescripiton)|\(model.measuredValue)|")
    }
}

class FileWarningView: WarningView {
//    var data: WarningModel
//
//    init(data: WarningModel) {
//        self.data = data
//    }
}
