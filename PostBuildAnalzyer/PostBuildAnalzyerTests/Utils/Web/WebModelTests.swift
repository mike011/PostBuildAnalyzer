//
//  WebModelTests.swift
//  PostBuildAnalzyerTests
//
//  Created by Michael Charland on 2020-01-10.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import XCTest

class WebModelTests: XCTestCase {
    func testAddBlankLine() {
        let wm = WebModel()
        wm.addBlankLine()
        XCTAssertEqual(wm.elements.count, 1)
    }

    func testAddTable() {
        let wm = WebModel()
        wm.add(table: Table(headers: [TableHeader(title: "", alignment: nil)]))
        XCTAssertEqual(wm.elements.count, 1)
    }

    func testAddHeader() {
        let wm = WebModel()
        wm.addHeader(level: 3, title: "H")
        XCTAssertEqual(wm.elements.count, 1)
    }

    func testToHTML() {
        let wm = WebModel()
        wm.addBlankLine()
        XCTAssertEqual(["<head><meta charset='utf-8'></head>", " "], wm.toHTML())
    }

    func testToMarkdown() {
        let wm = WebModel()
        wm.addBlankLine()
        XCTAssertEqual([" "], wm.toMarkdown())
    }

    func testTableToHTML() {
        // Given
        let header = TableHeader(title: "Title", alignment: .Center)
        let table = Table(headers: [header])
        table.add(row: MockTableRowModel(columns: ["First"]))
        let wm = WebModel()

        // When
        wm.add(table: table)
        let actual = wm.toHTML()

        // Then
        var result = [String]()
        result.append("<head><meta charset='utf-8'></head>")
        result.append("<table border=\"1\">")
        result.append("<tr>")
        result.append("<th>Title</th>")
        result.append("</tr>")
        result.append("<tr>")
        result.append("<td align=\"center\">First</td>")
        result.append("</tr>")
        result.append("</table>")
        XCTAssertStringArray(actual, result)
    }
}
