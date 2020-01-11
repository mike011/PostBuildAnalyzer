//
//  Warning.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-24.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class WarningController: Hashable, Equatable {
    var model: WarningModel
    var view: WarningView

    init(model: WarningModel, view: WarningView) {
        self.model = model
        self.view = view
        fillRow()
    }

    static func == (lhs: WarningController, rhs: WarningController) -> Bool {
        return lhs.model.line == rhs.model.line
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(model.line)
    }

    func addDuplicate() {
        model.count += 1
    }

    func getTotalWarnings() -> Int {
        return model.count
    }

    func fillRow() {
        view.fillRow(model: model)
    }
}
