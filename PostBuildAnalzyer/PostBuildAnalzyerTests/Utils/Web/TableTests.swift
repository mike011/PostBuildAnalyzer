//
//  TableTests.swift
//  PostBuildAnalzyerTests
//
//  Created by Michael Charland on 2020-01-10.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import XCTest

class TableTests: XCTestCase {
    // MARK: - toHTML

    func testToHTMLEmptyTable() {
        let header = TableHeader(title: "TITLE", alignment: nil)
        let table = Table(headers: [header])
        XCTAssertEqual(table.toHTML(), [])
    }

    func testToHTMLOneRow() {
        // Given
        let header = TableHeader(title: "TITLE", alignment: nil)
        let table = Table(headers: [header])

        // When
        table.addRow(columns: ["One"])

        // Then
        var result = [String]()
        result.append("<table>")
        result.append("<tr>")
        result.append("<th>TITLE</th>")
        result.append("</tr>")
        result.append("<tr>")
        result.append("<td>One</td>")
        result.append("</tr>")
        result.append("</table>")
        XCTAssertEqual(table.toHTML(), result)
    }

    func testToHTMLOneRowWithAlignment() {
        // Given
        let header = TableHeader(title: "Align Test", alignment: .Center)
        let table = Table(headers: [header])

        // When
        table.addRow(columns: ["Centered"])

        // Then
        var result = [String]()
        result.append("<table>")
        result.append("<tr>")
        result.append("<th>Align Test</th>")
        result.append("</tr>")
        result.append("<tr>")
        result.append("<td align=\"center\">Centered</td>")
        result.append("</tr>")
        result.append("</table>")
        XCTAssertStringArray(expression1: table.toHTML(), expression2: result)
    }

    func testToHTMLMultipleRowsAndColumnsWithAlignment() {
        // Given
        let header = TableHeader(title: "Align", alignment: .Center)
        let header2 = TableHeader(title: "Test", alignment: .Left)
        let table = Table(headers: [header, header2])

        // When
        table.addRow(columns: ["First", "Second"])
        table.addRow(columns: ["Again", "True"])
        var result = [String]()
        result.append("<table>")
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
        XCTAssertStringArray(expression1: table.toHTML(), expression2: result)
    }

    // MARK: - toMarkdown

    func testToMarkdownEmptyTable() {
        let header = TableHeader(title: "TITLE", alignment: nil)
        let table = Table(headers: [header])
        XCTAssertEqual(table.toMarkdown(), [])
    }

    func testToMarkdownOneRow() {
        // Given
        let header = TableHeader(title: "TITLE", alignment: nil)
        let table = Table(headers: [header])

        // When
        table.addRow(columns: ["One"])

        // Then
        var result = [String]()
        result.append("|TITLE|")
        result.append("|---|")
        result.append("|One|")
        XCTAssertStringArray(expression1: table.toMarkdown(), expression2: result)
    }

    func testToMarkdownOneRowWithAlignment() {
        // Given
        let header = TableHeader(title: "Align Test", alignment: .Center)
        let table = Table(headers: [header])

        // When
        table.addRow(columns: ["Centered"])

        // Then
        var result = [String]()
        result.append("|Align Test|")
        result.append("|:---:|")
        result.append("|Centered|")
        XCTAssertStringArray(expression1: table.toMarkdown(), expression2: result)
    }

    func testToMarkdownMultipleRowsAndColumnsWithAlignment() {
        // Given
        let header = TableHeader(title: "Align", alignment: .Center)
        let header2 = TableHeader(title: "Test", alignment: .Left)
        let table = Table(headers: [header, header2])

        // When
        table.addRow(columns: ["First", "Second"])
        table.addRow(columns: ["Again", "True"])
        var result = [String]()
        result.append("|Align|Test|")
        result.append("|:---:|:---|")
        result.append("|First|Second|")
        result.append("|Again|True|")
        XCTAssertStringArray(expression1: table.toMarkdown(), expression2: result)
    }
}

extension XCTest {
    func XCTAssertStringArray(expression1: [String], expression2: [String], file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(expression1.count, expression2.count, "size does not match", file: file, line: line)
        for x in 0 ..< expression1.count {
            XCTAssertEqual(expression1[x], expression2[x], "line does not match", file: file, line: line)
        }
    }
}
