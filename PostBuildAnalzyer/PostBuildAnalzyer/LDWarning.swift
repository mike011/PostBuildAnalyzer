//
//  LDWarning.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-20.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class LDWarning: SimpleWarning {
    static let lookFor = "ld: warning: "

    var descripton: String

    init(description: String) {
        self.descripton = String(description.dropFirst(LDWarning.lookFor.count))
    }
}
