//
//  SlowExpressionView.swift
//  PostBuildAnalyzer
//
//  Created by Michael Charland on 2019-12-26.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class SlowExpressionView: WarningView {
    var columns = [String]()
    var symbol: String = "⏱"

    func getDetailedDescription(model: WarningModel) -> String {
        guard let model = model as? SlowExpressionModel else {
            return ""
        }
        return "\(getAHREF(model: model)) on line \(model.lineNumber) \(model.description)"
    }

    func getMeasuredValue(model: WarningModel) -> String {
        guard let model = model as? SlowExpressionModel else {
            return ""
        }
        return String(format: "%.2fms", model.timeInMS)
    }

    func getAHREF(model: SlowExpressionModel) -> String {
        return HTML.getAHREF(url: model.url, title: model.getFilename())
    }
}
