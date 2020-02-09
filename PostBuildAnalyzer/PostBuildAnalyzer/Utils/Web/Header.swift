//
//  Header.swift
//  PostBuildAnalyzer
//
//  Created by Michael Charland on 2020-01-10.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import Foundation

class Header: Element {
    let level: Int
    let title: String
    init(level: Int, title: String) {
        self.level = level
        self.title = title
    }

    func toHTML() -> [String] {
        return ["<H\(level)>\(title)</H\(level)>"]
    }

    func toMarkdown() -> [String] {
        return ["<H\(level)>\(title)</H\(level)>"]
    }
}
