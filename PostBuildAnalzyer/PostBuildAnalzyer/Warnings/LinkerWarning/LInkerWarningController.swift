//
//  LinkerWarningController.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-20.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class LinkerWarningController: WarningController {
    init(line: String) {
        let model = LinkerWarningModel(line: line)
        let view = LinkerWarningView()
        super.init(model: model, view: view)
    }
}

extension PostBuildAnalzyer {
    func isLinkerWarning(line: String) -> Bool {
        return line.contains(LinkerWarningModel.lookFor)
    }
}
