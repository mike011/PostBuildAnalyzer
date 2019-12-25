//
//  LinkerWarningView.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-25.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class LinkerWarningView: WarningView {
    let symbol = "⚠️"

    func getDetailedDescription(model: WarningModel) -> String {
        return model.description
    }

    func getMeasuredValue(model: WarningModel) -> String {
        return "\(model.count) times"
    }
}
