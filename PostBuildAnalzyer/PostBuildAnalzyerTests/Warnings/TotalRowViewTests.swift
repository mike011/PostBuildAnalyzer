//
//  TotalRowViewTests.swift
//  PostBuildAnalzyerTests
//
//  Created by Michael Charland on 2020-01-01.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import XCTest

class TotalRowViewTests: XCTestCase {
    // MARK: - change

    func testChangeNoChange() {
        let totalRowView = TestTotalRowView()
        XCTAssertEqual(totalRowView.change, "")
    }

    func testChangeMoreWarnings() {
        let totalRowView = TestTotalRowView()
        totalRowView.after.append(TestWarningController())
        XCTAssertEqual(totalRowView.change, "👎")
    }

    func testChangeLessWarnings() {
        let totalRowView = TestTotalRowView()
        totalRowView.before.append(TestWarningController())
        XCTAssertEqual(totalRowView.change, "👍")
    }

    // MARK: - hasResult

    func testHasResultsNoWarnings() {
        let totalRowView = TestTotalRowView()
        XCTAssertFalse(totalRowView.hasResults)
    }

    func testHasResultsOnlyBeforeWarning() {
        let totalRowView = TestTotalRowView()
        totalRowView.before.append(TestWarningController())
        XCTAssertTrue(totalRowView.hasResults)
    }

    func testHasResultsOnlyAfterWarning() {
        let totalRowView = TestTotalRowView()
        totalRowView.after.append(TestWarningController())
        XCTAssertTrue(totalRowView.hasResults)
    }

    func testHasResultsBothBeforeAndAfter() {
        let totalRowView = TestTotalRowView()
        totalRowView.before.append(TestWarningController())
        totalRowView.after.append(TestWarningController())
        XCTAssertTrue(totalRowView.hasResults)
    }

    func testRow() {
        let totalRowView = TestTotalRowView()
        XCTAssertEqual(totalRowView.row(baseURL: URL(string: "http://a.b")), "||S|D|<a href=\"http://a.b/before.html\">0</a>|<a href=\"http://a.b/after.html\">0</a>|")
    }

    func testRowWithExtraSlashes() {
        let totalRowView = TestTotalRowView()
        XCTAssertEqual(totalRowView.row(baseURL: URL(string: "http://a.b/")), "||S|D|<a href=\"http://a.b/before.html\">0</a>|<a href=\"http://a.b/after.html\">0</a>|")
    }

    func testRowNoURL() {
        let totalRowView = TestTotalRowView()
        XCTAssertEqual(totalRowView.row(baseURL: nil), "||S|D|0|0|")
    }
}
