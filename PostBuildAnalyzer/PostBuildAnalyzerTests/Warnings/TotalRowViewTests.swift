//
//  TotalRowViewTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2020-01-01.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import XCTest

class TotalRowViewTests: XCTestCase {
    // MARK: - change

    func testChangeNoChange() {
        let totalRowView = MockTotalRowView()
        XCTAssertEqual(totalRowView.change, "")
    }

    func testChangeMoreWarnings() {
        let totalRowView = MockTotalRowView()
        totalRowView.after.append(MockWarningController())
        XCTAssertEqual(totalRowView.change, "👎")
    }

    func testChangeLessWarnings() {
        let totalRowView = MockTotalRowView()
        totalRowView.before.append(MockWarningController())
        XCTAssertEqual(totalRowView.change, "👍")
    }

    // MARK: - hasResult

    func testHasResultsNoWarnings() {
        let totalRowView = MockTotalRowView()
        XCTAssertFalse(totalRowView.hasResults)
    }

    func testHasResultsNoWarningsNoLink() {
        let totalRowView = MockTotalRowView()
        XCTAssertEqual(totalRowView.row(baseURL: URL(string: "www.nba.com")).columns[3], "0")
    }

    func testHasResultsOnlyBeforeWarning() {
        let totalRowView = MockTotalRowView()
        totalRowView.before.append(MockWarningController())
        XCTAssertTrue(totalRowView.hasResults)
    }

    func testHasResultsOnlyAfterWarning() {
        let totalRowView = MockTotalRowView()
        totalRowView.after.append(MockWarningController())
        XCTAssertTrue(totalRowView.hasResults)
    }

    func testHasResultsBothBeforeAndAfter() {
        let totalRowView = MockTotalRowView()
        totalRowView.before.append(MockWarningController())
        totalRowView.after.append(MockWarningController())
        XCTAssertTrue(totalRowView.hasResults)
    }

    func testRow() {
        let totalRowView = MockTotalRowView()
        XCTAssertEqual(totalRowView.row(baseURL: URL(string: "http://a.b")).columns[0], "")
        XCTAssertEqual(totalRowView.row(baseURL: URL(string: "http://a.b")).columns[1], "S")
        XCTAssertEqual(totalRowView.row(baseURL: URL(string: "http://a.b")).columns[2], "D")
        XCTAssertEqual(totalRowView.row(baseURL: URL(string: "http://a.b")).columns[3], "0")
        XCTAssertEqual(totalRowView.row(baseURL: URL(string: "http://a.b")).columns[4], "0")
    }

    func testRowWithExtraSlashes() {
        let totalRowView = MockTotalRowView()
        XCTAssertEqual(totalRowView.row(baseURL: URL(string: "http://a.b/")).columns[3], "0")
    }

    func testRowNoURL() {
        let totalRowView = MockTotalRowView()
        XCTAssertEqual(totalRowView.row(baseURL: nil).columns[3], "0")
        XCTAssertEqual(totalRowView.row(baseURL: nil).columns[4], "0")
    }
}
