//
//  LinkerModel.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-25.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class LDWarningModel: WarningModel {
    var line: String

    var count: Int = 1

    static let lookFor = "ld: warning: "
    var description: String

    init(description: String) {
        self.line = description
        self.description = String(description.dropFirst(Self.lookFor.count))
    }
}
