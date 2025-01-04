//
//  TotalRowViewTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2020-01-01.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import Foundation
import Testing

@Suite struct TotalRowViewTests {
    // MARK: - change

    @Test func changeNoChange() {
        let totalRowView = MockTotalRowView()
        #expect(totalRowView.change == "")
    }

    @Test func changeMoreWarnings() {
        let totalRowView = MockTotalRowView()
        totalRowView.after.append(MockWarningController())
        #expect(totalRowView.change == "👎")
    }

    @Test func changeLessWarnings() {
        let totalRowView = MockTotalRowView()
        totalRowView.before.append(MockWarningController())
        #expect(totalRowView.change == "👍")
    }

    // MARK: - hasResult

    @Test func hasResultsNoWarnings() {
        let totalRowView = MockTotalRowView()
        #expect(!totalRowView.hasResults)
    }

    @Test func hasResultsNoWarningsNoLink() {
        let totalRowView = MockTotalRowView()
        #expect(totalRowView.row(baseURL: URL(string: "www.nba.com")).columns[3] == "0")
    }

    @Test func hasResultsOnlyBeforeWarning() {
        let totalRowView = MockTotalRowView()
        totalRowView.before.append(MockWarningController())
        #expect(totalRowView.hasResults)
    }

    @Test func hasResultsOnlyAfterWarning() {
        let totalRowView = MockTotalRowView()
        totalRowView.after.append(MockWarningController())
        #expect(totalRowView.hasResults)
    }

    @Test func hasResultsBothBeforeAndAfter() {
        let totalRowView = MockTotalRowView()
        totalRowView.before.append(MockWarningController())
        totalRowView.after.append(MockWarningController())
        #expect(totalRowView.hasResults)
    }

    @Test func row() {
        let totalRowView = MockTotalRowView()
        #expect(totalRowView.row(baseURL: URL(string: "http://a.b")).columns[0] == "")
        #expect(totalRowView.row(baseURL: URL(string: "http://a.b")).columns[1] == "S")
        #expect(totalRowView.row(baseURL: URL(string: "http://a.b")).columns[2] == "D")
        #expect(totalRowView.row(baseURL: URL(string: "http://a.b")).columns[3] == "0")
        #expect(totalRowView.row(baseURL: URL(string: "http://a.b")).columns[4] == "0")
    }

    @Test func rowWithExtraSlashes() {
        let totalRowView = MockTotalRowView()
        #expect(totalRowView.row(baseURL: URL(string: "http://a.b/")).columns[3] == "0")
    }

    @Test func rowNoURL() {
        let totalRowView = MockTotalRowView()
        #expect(totalRowView.row(baseURL: nil).columns[3] == "0")
        #expect(totalRowView.row(baseURL: nil).columns[4] == "0")
    }
}
