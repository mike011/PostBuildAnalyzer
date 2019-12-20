//
//  Warning.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-20.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class Warning: SimpleWarning {
    static var lookFor = ": warning: "

    var descripton: String
    var file: String
    var lineNumber: Int
    var indent: Int
    var warning: String
    var count: Int

    init(line: String) {
        file = ""
        lineNumber = 0
        indent = 0
        warning = ""
        count = 1
        descripton = line
    }
}
