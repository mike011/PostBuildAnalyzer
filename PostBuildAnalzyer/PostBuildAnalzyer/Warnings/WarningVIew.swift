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

class FileWarningView: WarningView {
    let symbol = "⚠️"

    func getDetailedDescription(model: WarningModel) -> String {
        guard let model = model as? FileWarningModel else {
            return ""
        }

        if model.file.isEmpty {
            return model.description
        } else {
            return "\(getAHREF(model: model)) on line \(model.lineNumber)<br><i>\(model.description)</i>"
        }
    }

    func getMeasuredValue(model: WarningModel) -> String {
        return "\(model.count) times"
    }

    func getAHREF(model: FileWarningModel) -> String {
        return "<a href=\"\(model.getURL())\">\(model.getFilename())</a>"
    }
}
