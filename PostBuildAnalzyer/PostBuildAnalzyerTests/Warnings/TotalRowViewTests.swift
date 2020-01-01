//
//  TotalRowViewTests.swift
//  PostBuildAnalzyerTests
//
//  Created by Michael Charland on 2020-01-01.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import XCTest

class TotalRowViewTests: XCTestCase {
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
}
