//
//  MockWarningModel.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2019-12-25.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class MockWarningModel: WarningModel {
    nonisolated(unsafe) static var lookFor = ""
    var line = ""
    var description = ""
    var count = 1.0
}
