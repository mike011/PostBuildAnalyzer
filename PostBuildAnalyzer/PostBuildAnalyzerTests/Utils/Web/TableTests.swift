//
//  TableTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2020-01-10.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import Testing

@Suite struct TableTests {
    // MARK: - toHTML

    @Test func toHTMLEmptyTable() {
        let header = TableHeader(title: "TITLE", alignment: nil)
        let table = Table(headers: [header])
        #expect(table.toHTML() == [])
    }

    @Test func toHTMLOneRow() {
        // Given
        let header = TableHeader(title: "TITLE", alignment: nil)
        let table = Table(headers: [header])
        let row = MockTableRowModel(columns: ["One"])

        // When
        table.add(row: row)

        // Then
        var result = [String]()
        result.append("<table border=\"1\">")
        result.append("<tr>")
        result.append("<th>TITLE</th>")
        result.append("</tr>")
        result.append("<tr>")
        result.append("<td>One</td>")
        result.append("</tr>")
        result.append("</table>")
        #expect(table.toHTML() == result)
    }

    @Test func toHTMLOneRowWithAlignment() {
        // Given
        let header = TableHeader(title: "Align Test", alignment: .Center)
        let table = Table(headers: [header])
        let row = MockTableRowModel(columns: ["Centered"])

        // When
        table.add(row: row)

        // Then
        var result = [String]()
        result.append("<table border=\"1\">")
        result.append("<tr>")
        result.append("<th>Align Test</th>")
        result.append("</tr>")
        result.append("<tr>")
        result.append("<td align=\"center\">Centered</td>")
        result.append("</tr>")
        result.append("</table>")
        XCTAssertStringArray(table.toHTML(), result)
    }

    @Test func toHTMLMultipleRowsAndColumnsWithAlignment() {
        // Given
        let header = TableHeader(title: "Align", alignment: .Center)
        let header2 = TableHeader(title: "Test", alignment: .Left)
        let table = Table(headers: [header, header2])
        let row = MockTableRowModel(columns: ["First", "Second"])
        let row2 = MockTableRowModel(columns: ["Again", "True"])

        // When
        table.add(row: row)
        table.add(row: row2)

        // THen
        var result = [String]()
        result.append("<table border=\"1\">")
        result.append("<tr>")
        result.append("<th>Align</th>")
        result.append("<th>Test</th>")
        result.append("</tr>")
        result.append("<tr>")
        result.append("<td align=\"center\">First</td>")
        result.append("<td align=\"left\">Second</td>")
        result.append("</tr>")
        result.append("<tr>")
        result.append("<td align=\"center\">Again</td>")
        result.append("<td align=\"left\">True</td>")
        result.append("</tr>")
        result.append("</table>")
        XCTAssertStringArray(table.toHTML(), result)
    }

    // MARK: - toMarkdown

    @Test func toMarkdownEmptyTable() {
        let header = TableHeader(title: "TITLE", alignment: nil)
        let table = Table(headers: [header])
        #expect(table.toMarkdown() == [])
    }

    @Test func toMarkdownOneRow() {
        // Given
        let header = TableHeader(title: "TITLE", alignment: nil)
        let table = Table(headers: [header])
        let row = MockTableRowModel(columns: ["One"])

        // When
        table.add(row: row)

        // Then
        var result = [String]()
        result.append("|TITLE|")
        result.append("|---|")
        result.append("|One|")
        XCTAssertStringArray(table.toMarkdown(), result)
    }

    @Test func toMarkdownOneRowWithAlignment() {
        // Given
        let header = TableHeader(title: "Align Test", alignment: .Center)
        let table = Table(headers: [header])
        let row = MockTableRowModel(columns: ["Centered"])

        // When
        table.add(row: row)

        // Then
        var result = [String]()
        result.append("|Align Test|")
        result.append("|:---:|")
        result.append("|Centered|")
        XCTAssertStringArray(table.toMarkdown(), result)
    }

    @Test func toMarkdownMultipleRowsAndColumnsWithAlignment() {
        // Given
        let header = TableHeader(title: "Align", alignment: .Center)
        let header2 = TableHeader(title: "Test", alignment: .Left)
        let table = Table(headers: [header, header2])
        let row = MockTableRowModel(columns: ["First", "Second"])
        let row2 = MockTableRowModel(columns: ["Again", "True"])

        // When
        table.add(row: row)
        table.add(row: row2)

        // Then
        var result = [String]()
        result.append("|Align|Test|")
        result.append("|:---:|:---|")
        result.append("|First|Second|")
        result.append("|Again|True|")
        XCTAssertStringArray(table.toMarkdown(), result)
    }
}

func XCTAssertStringArray(_ expression1: [String], _ expression2: [String]) {
    #expect(expression1.count == expression2.count, "size does not match")
    for x in 0..<expression1.count {
        #expect(expression1[x] == expression2[x], "line does not match")
    }
}
