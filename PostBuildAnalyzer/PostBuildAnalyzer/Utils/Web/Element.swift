//
//  Element.swift
//  PostBuildAnalyzer
//
//  Created by Michael Charland on 2020-01-10.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import Foundation

protocol Element {
    func toHTML() -> [String]
    func toMarkdown() -> [String]
}
