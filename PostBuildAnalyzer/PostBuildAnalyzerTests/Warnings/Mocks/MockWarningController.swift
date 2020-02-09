//
//  MockWarningController.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2020-01-01.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import Foundation

class MockWarningController: WarningController {
    init() {
        super.init(model: MockWarningModel(), view: MockWarningView())
    }
}
