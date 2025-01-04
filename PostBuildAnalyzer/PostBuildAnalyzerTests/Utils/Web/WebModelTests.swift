//
//  WebModelTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2020-01-10.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import Testing

@Suite struct WebModelTests {
    @Test func addBlankLine() {
        let wm = WebModel()
        wm.addBlankLine()
        #expect(wm.elements.count == 1)
    }

    @Test func addTable() {
        let wm = WebModel()
        wm.add(table: Table(headers: [TableHeader(title: "", alignment: nil)]))
        #expect(wm.elements.count == 1)
    }

    @Test func addHeader() {
        let wm = WebModel()
        wm.addHeader(level: 3, title: "H")
        #expect(wm.elements.count == 1)
    }

    @Test func toHTML() {
        let wm = WebModel()
        wm.addBlankLine()
        #expect(["<head><meta charset='utf-8'></head>", " "] == wm.toHTML())
    }

    @Test func toMarkdown() {
        let wm = WebModel()
        wm.addBlankLine()
        #expect([" "] == wm.toMarkdown())
    }

    @Test func tableToHTML() {
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
