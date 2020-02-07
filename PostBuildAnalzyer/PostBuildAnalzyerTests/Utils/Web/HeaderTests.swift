//
//  HeaderTests.swift
//  PostBuildAnalzyerTests
//
//  Created by Michael Charland on 2020-01-10.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import XCTest

class HeaderTests: XCTestCase {
    private let header = Header(level: 2, title: "title")

    func testToHTML() {
        XCTAssertEqual(header.toHTML(), ["<H2>title</H2>"])
    }

    func testToMarkdown() {
        XCTAssertEqual(header.toMarkdown(), ["<H2>title</H2>"])

        let header4 = Header(level: 4, title: "monkey")
        XCTAssertEqual(header4.toMarkdown(), ["<H4>monkey</H4>"])
    }
}
