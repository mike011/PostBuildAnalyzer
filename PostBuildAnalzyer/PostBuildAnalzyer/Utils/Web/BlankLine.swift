//
//  BlankLine.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2020-01-10.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import Foundation

class BlankLine: Element {
    func toHTML() -> [String] {
        return ["<BR>"]
    }

    func toMarkdown() -> [String] {
        return ["<BR>"]
    }
}
