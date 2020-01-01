//
//  UtilsTests.swift
//  PostBuildAnalzyerTests
//
//  Created by Michael Charland on 2019-12-01.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import XCTest

class UtilsTests: XCTestCase {
    func testGetParentFileNameWithSlashReturnsFolder() {
        XCTAssertEqual(Utils.getParentURL(file: "a/b.json").absoluteString, URL(fileURLWithPath: "a").absoluteString + "/")
    }

    func testGetParentFileForURL() {
        XCTAssertEqual(Utils.getParentURL(web: "http://www.nba.com/b.json").absoluteString, URL(string: "http://www.nba.com/")?.absoluteURL.absoluteString)
    }

    func testTrimSpaces() {
        XCTAssertEqual(" ".trimSpaces(), "")
        XCTAssertEqual("a ".trimSpaces(), "a")
        XCTAssertEqual(" a".trimSpaces(), "a")
        XCTAssertEqual(" a ".trimSpaces(), "a")
        XCTAssertEqual("       a                     ".trimSpaces(), "a")
    }

    func testSplits() {
        XCTAssertEqual(Utils.getSplits(description: ""), [String]())
        XCTAssertEqual(Utils.getSplits(description: " "), [String]())
        XCTAssertEqual(Utils.getSplits(description: "   "), [String]())
        XCTAssertEqual(Utils.getSplits(description: "a"), ["a"])
        XCTAssertEqual(Utils.getSplits(description: " a "), ["a"])
        XCTAssertEqual(Utils.getSplits(description: " a\tb"), ["a", "b"])
    }

    func testLoadData() {
        XCTAssertNil(Utils.loadData(type: Arguments.self, file: nil))
        XCTAssertNil(Utils.loadData(type: Arguments.self, file: "File does not exist"))
        XCTAssertNotNil(Utils.loadData(type: Arguments.self, file: EXAMPLE_JSON))
    }

    func testLoad() {
        XCTAssertTrue(Utils.load(file: nil).isEmpty)
        XCTAssertFalse(Utils.load(file: EXAMPLE_JSON).isEmpty)
    }
}
