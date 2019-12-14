//
//  RowTests.swift
//  CodeCoverageFrameworkTests
//
//  Created by Michael Charland on 2019-11-15.
//  Copyright © 2019 charland. All rights reserved.
//

import XCTest

class RowTests: XCTestCase {

    // MARK: - Only Before covered
    func testCoverageBefore100() {
        let row = Row(sourceFile: "file", beforeCoverage: 1, afterCoverage: nil)
        XCTAssertEqual(row.change, "")
    }

    func testCoverageBeforeNone() {
        let row = Row(sourceFile: "file", beforeCoverage: 0, afterCoverage: nil)
        XCTAssertEqual(row.change, "")
    }

    func testRowPRCoverageBefore() {
        let row = Row(sourceFile: "file", beforeCoverage: 30, afterCoverage: nil)
        XCTAssertEqual(row.change, "")
    }

    func testVirtually100Before() {
        let row = Row(sourceFile: "file", beforeCoverage: 290/291, afterCoverage: nil)
        XCTAssertEqual(row.change, "")
    }

    // MARK: - Only After covered
    func testCoverageAfter100() {
        let row = Row(sourceFile: "file", beforeCoverage: nil, afterCoverage: 1)
        XCTAssertEqual(row.change, "💯")
    }

    func testCoverageAfterNone() {
        let row = Row(sourceFile: "file", beforeCoverage: nil, afterCoverage: 0)
        XCTAssertEqual(row.change, "🚫")
    }

    func testRowPRCoverageAfter() {
        let row = Row(sourceFile: "file", beforeCoverage: nil, afterCoverage: 30)
        XCTAssertEqual(row.change, "👍")
    }

    func testVirtually100After() {
        let row = Row(sourceFile: "file", beforeCoverage: nil, afterCoverage: 290/291)
        XCTAssertEqual(row.change, "💯")
    }

    // MARK: - Both files covered
    func testRowPRAllCovered() {
        let row = Row(sourceFile: "file", beforeCoverage: 0, afterCoverage: 1)
        XCTAssertEqual(row.change, "💯")
    }

    func testRowPRNotCovered() {
        let row = Row(sourceFile: "file", beforeCoverage: 0, afterCoverage: 0)
        XCTAssertEqual(row.change, "🚫")
    }

    func testRowPRCoverageDown() {
        let row = Row(sourceFile: "file", beforeCoverage: 30, afterCoverage: 25)
        XCTAssertEqual(row.change, "👎")
    }

    func testRowPRCoverageUp() {
        let row = Row(sourceFile: "file", beforeCoverage: 25, afterCoverage: 30)
        XCTAssertEqual(row.change, "👍")
    }

    func testVirtually100SlightyHigherAfter() {
        let row = Row(sourceFile: "file", beforeCoverage: 289/290, afterCoverage: 290/291)
        XCTAssertEqual(row.change, "💯")
    }

    func testVirtually100SlightyHigherBefore() {
        let row = Row(sourceFile: "file", beforeCoverage: 290/291, afterCoverage: 289/290)
        XCTAssertEqual(row.change, "💯")
    }

    func testLessThenOnePercentChange() {
        let row = Row(sourceFile: "file", beforeCoverage: 900/1000, afterCoverage: 904/1000)
        XCTAssertEqual(row.change, "")
    }

    func testMoreThenOnePercentChangeBetter() {
        let row = Row(sourceFile: "file", beforeCoverage: 98/100, afterCoverage: 99/100)
        XCTAssertEqual(row.change, "👍")
    }

    func testMoreThenOnePercentChangeWorse() {
        let row = Row(sourceFile: "file", beforeCoverage: 99/100, afterCoverage: 98/100)
        XCTAssertEqual(row.change, "👎")
    }


    // MARK: - Rest

    func testIsTest() {
        let row = Row(sourceFile: "Test", beforeCoverage: 0, afterCoverage: 0)
        XCTAssertTrue(row.test)
    }

    func testIsNotTest() {
        let row = Row(sourceFile: "file", beforeCoverage: 0, afterCoverage: 0)
        XCTAssertFalse(row.test)
    }

    func testEquals() {
        let row = Row(sourceFile: "file", beforeCoverage: 0, afterCoverage: 0)
        let row2 = Row(sourceFile: "file", beforeCoverage: 0, afterCoverage: 0)
        XCTAssertTrue(row == row2)
    }

    func testNotEquals() {
        let row = Row(sourceFile: "file", beforeCoverage: 0, afterCoverage: 0)
        let row2 = Row(sourceFile: "file2", beforeCoverage: 0, afterCoverage: 0)
        XCTAssertFalse(row == row2)
    }

    func testGetName() {
        let row = Row(sourceFile: "file", beforeCoverage: 0, afterCoverage: 0)
        XCTAssertEqual(row.getName(), "file")
    }

    func testGetNameWithPeriod() {
        let row = Row(sourceFile: "file.swift", beforeCoverage: 0, afterCoverage: 0)
        XCTAssertEqual(row.getName(), "file")
    }

    func testToString() {
        let row = Row(sourceFile: "file.swift", beforeCoverage: 0, afterCoverage: 0)
        XCTAssertEqual(row.toString(parentURL: "http://a.b/", end: ".html"), "|🚫|<a href=http://a.b/file.html>file</a>|0%|0%|")
    }

    func testToStringNotCovered() {
        let row = Row(sourceFile: "file.swift", beforeCoverage: nil, afterCoverage: nil)
        XCTAssertEqual(row.toString(parentURL: "http://a.b/", end: ".html"), "||<a href=http://a.b/file.html>file</a>|-|-|")
    }

}
