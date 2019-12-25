//
//  Link.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-24.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class Link {
    /// The file in which the error occurred
    let file: String = ""

    /// The line number on which the error occurred
    var lineNumber: Int = 0

    /// The spot on the line where the error occurred
    var indent: Int = 0

    init(line: String) {}
}
