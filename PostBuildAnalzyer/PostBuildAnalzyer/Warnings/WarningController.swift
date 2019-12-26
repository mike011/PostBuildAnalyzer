//
//  Warning.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-24.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class WarningController: Hashable, Equatable {
    private var model: WarningModel
    private var view: WarningView

    init(model: WarningModel, view: WarningView) {
        self.model = model
        self.view = view
    }

    static func == (lhs: WarningController, rhs: WarningController) -> Bool {
        return lhs.model.line == rhs.model.line
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(model.line)
    }

    @discardableResult
    func printView() -> String {
        return view.printRow(model: model)
    }

    func addDuplicate() {
        model.count += 1
    }

    func getTotalWarnings() -> Int {
        return model.count
    }
}
