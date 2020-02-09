//
//  LinkerWarningModel.swift
//  PostBuildAnalyzer
//
//  Created by Michael Charland on 2019-12-25.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class LinkerWarningModel: WarningModel {
    var line: String

    var count = 1.0

    static let lookFor = "ld: warning: "
    var description: String

    init(line: String) {
        self.line = line
        self.description = String(line.dropFirst(Self.lookFor.count))
    }
}
