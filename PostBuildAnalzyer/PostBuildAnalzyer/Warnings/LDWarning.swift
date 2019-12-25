//
//  LDWarning.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-20.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class LDWarningController: WarningController {
    init(description: String) {
        let model = LDWarningModel(description: description)
        let view = LinkerWarningView()
        super.init(model: model, view: view)
    }
}

class LDWarningModel: WarningModel {
    var line: String

    var count: Int = 1

    static let lookFor = "ld: warning: "
    let symbol = "⚠️"

    var description: String

    init(description: String) {
        self.line = description
        self.description = String(description.dropFirst(Self.lookFor.count))
    }

    var detailedDescripiton: String {
        return description
    }

    var measuredValue: String {
        return "\(count) times"
    }
}

extension PostBuildAnalzyer {
    func isLDWarning(line: String) -> Bool {
        return line.contains(LDWarningModel.lookFor)
    }
}
