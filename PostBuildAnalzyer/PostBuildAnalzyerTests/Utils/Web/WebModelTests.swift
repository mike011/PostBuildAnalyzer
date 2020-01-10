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
        XCTAssertEqual(["<BR>"], wm.toHTML())
    }

    func testToMarkdown() {
        let wm = WebModel()
        wm.addBlankLine()
        XCTAssertEqual(["<BR>"], wm.toMarkdown())
    }
}
