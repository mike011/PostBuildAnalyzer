//
//  FileWarningTests.swift
//  PostBuildAnalzyerTests
//
//  Created by Michael Charland on 2019-12-20.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import XCTest

class FileWarningTests: XCTestCase {
    func testWarning() {
        let description = "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/ExistingClassCovered.swift:15:26: warning: 'index(of:)' is deprecated: renamed to 'firstIndex(of:)'"
        let warning = FileWarning(repoName: "PostBuildAnalyzer", firstLine: description)
        XCTAssertEqual(warning.file, "example/Before/Example/ExistingClassCovered.swift")
        XCTAssertEqual(warning.lineNumber, 15)
        XCTAssertEqual(warning.indent, 26)
        XCTAssertEqual(warning.description, "'index(of:)' is deprecated: renamed to 'firstIndex(of:)'")
        XCTAssertTrue(warning.details.isEmpty)
        XCTAssertEqual(warning.count, 1)
    }

    func testWarningSingleDigitNumbers() {
        let description = "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/ExistingClassCovered.swift:1:2: warning: 'index(of:)' is deprecated: renamed to 'firstIndex(of:)'"
        let warning = FileWarning(repoName: "", firstLine: description)
        XCTAssertEqual(warning.lineNumber, 1)
        XCTAssertEqual(warning.indent, 2)
    }

    func testWarningTripleDigitNumbers() {
        let description = "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/ExistingClassCovered.swift:145:267: warning: 'index(of:)' is deprecated: renamed to 'firstIndex(of:)'"
        let warning = FileWarning(repoName: "", firstLine: description)
        XCTAssertEqual(warning.lineNumber, 145)
        XCTAssertEqual(warning.indent, 267)
    }

    func getSampleWarning() -> FileWarning {
        let warning = FileWarning(repoName: "PostBuildAnalyzer", firstLine: "Documents/git/PostBuildAnalyzer/example/Before/Example/ExistingClassCovered.swift:15:26: warning: 'index(of:)' is deprecated")
        warning.add(line: "if let index = s.index(of: \"a\") {")
        warning.add(line: "               ^")
        return warning
    }

    func getAnotherSampleWarning() -> FileWarning {
        let warning = FileWarning(repoName: "PostBuildAnalyzer", firstLine: "Documents/git/PostBuildAnalyzer/example/Before/Example/Frank.swift:16:15: warning: result of call to 'substring(to:)' is unused")
        warning.add(line: "s.substring(to: index)")
        warning.add(line: "  ^        ~~~~~~~~~~~")
        warning.count = 2
        return warning
    }

    func testAddLine() {
        let warning = getSampleWarning()
        XCTAssertEqual(warning.details.count, 1)
        XCTAssertEqual(warning.details[0], "if let index = s.index(of: \"a\") {")
    }

    func testSymbol() {
        let warning = getSampleWarning()
        XCTAssertEqual(warning.symbol, "⚠️")
    }

    func testDetailedDescripiton() {
        let warning = getSampleWarning()
        var col2 = "File: example/Before/Example/ExistingClassCovered.swift<br>"
        col2 += "Line: 15\tWarning: 'index(of:)' is deprecated<br>"
        col2 += "if let index = s.index(of: \"a\") {"
        XCTAssertEqual(warning.detaledDescripiton, col2)
    }

    func testMesauredValue() {
        let warning = getSampleWarning()
        XCTAssertEqual(warning.measuredValue, "1 times")
    }

    func testMesauredValueWithMultipleValues() {
        let warning = getAnotherSampleWarning()
        XCTAssertEqual(warning.measuredValue, "2 times")
    }
}
