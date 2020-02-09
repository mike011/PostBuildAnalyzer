//
//  LintWarningView.swift
//  PostBuildAnalyzer
//
//  Created by Michael Charland on 2020-02-05.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import Foundation

class LintWarningView: WarningView {
    var columns = [String]()
    let symbol = "🧽"

    func getDetailedDescription(model: WarningModel) -> String {
        guard let model = model as? LintWarningModel else {
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

    func getAHREF(model: LintWarningModel) -> String? {
        guard let url = model.url else {
            return nil
        }
        return HTML.getAHREF(url: url, title: model.getFilename())
    }
}
