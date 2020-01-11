//
//  BlankLineTests.swift
//  PostBuildAnalzyerTests
//
//  Created by Michael Charland on 2020-01-10.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import XCTest

class BlankLineTests: XCTestCase {
    private let blankLine = BlankLine()

    func testToHTML() {
        XCTAssertEqual(blankLine.toHTML(), [" "])
    }

    func testToMarkdown() {
        XCTAssertEqual(blankLine.toMarkdown(), [" "])
    }
}
