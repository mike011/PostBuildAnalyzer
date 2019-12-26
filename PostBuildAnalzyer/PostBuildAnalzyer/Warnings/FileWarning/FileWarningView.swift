//
//  FileWarningView.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-25.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class FileWarningView: WarningView {
    let symbol = "⚠️"

    func getDetailedDescription(model: WarningModel) -> String {
        guard let model = model as? FileWarningModel else {
            return ""
        }

        guard let ahref = getAHREF(model: model),
            let lineNumber = model.lineNumber else {
            return "\(model.file)<br><i>\(model.description)</i>"
        }

        return "\(ahref) on line \(lineNumber)<br><i>\(model.description)</i>"
    }

    func getMeasuredValue(model: WarningModel) -> String {
        return "\(Int(model.count)) times"
    }

    func getAHREF(model: FileWarningModel) -> String? {
        guard let url = model.url else {
            return nil
        }
        return "<a href=\"\(url.absoluteString)\">\(model.getFilename())</a>"
    }
}
