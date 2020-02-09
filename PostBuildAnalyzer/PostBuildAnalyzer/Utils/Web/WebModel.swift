//
//  WebModel.swift
//  PostBuildAnalyzer
//
//  Created by Michael Charland on 2020-01-10.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import Foundation

class WebModel: Element {
    var elements = [Element]()

    func addBlankLine() {
        elements.append(BlankLine())
    }

    func add(table: Table) {
        elements.append(table)
    }

    func addHeader(level: Int, title: String) {
        elements.append(Header(level: level, title: title))
    }

    func add(webModel: WebModel) {
        elements += webModel.elements
    }

    func toHTML() -> [String] {
        var result = [String]()
        result.append("<head><meta charset='utf-8'></head>")
        for element in elements {
            result += element.toHTML()
        }
        return result
    }

    func toMarkdown() -> [String] {
        var result = [String]()
        for element in elements {
            result += element.toMarkdown()
        }
        return result
    }
}
