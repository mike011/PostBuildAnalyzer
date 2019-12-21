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
        let warning = FileWarning(firstLine:description)
        XCTAssertEqual(warning.file, "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/ExistingClassCovered.swift")
        XCTAssertEqual(warning.lineNumber, 15)
        XCTAssertEqual(warning.indent, 26)
        XCTAssertEqual(warning.description, "'index(of:)' is deprecated: renamed to 'firstIndex(of:)'")
        XCTAssertTrue(warning.details.isEmpty)
        XCTAssertEqual(warning.count, 1)
    }

    func testWarningSingleDigitNumbers() {
        let description = "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/ExistingClassCovered.swift:1:2: warning: 'index(of:)' is deprecated: renamed to 'firstIndex(of:)'"
        let warning = FileWarning(firstLine:description)
        XCTAssertEqual(warning.lineNumber, 1)
        XCTAssertEqual(warning.indent, 2)
    }

    func testWarningTripleDigitNumbers() {
        let description = "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/ExistingClassCovered.swift:145:267: warning: 'index(of:)' is deprecated: renamed to 'firstIndex(of:)'"
        let warning = FileWarning(firstLine:description)
        XCTAssertEqual(warning.lineNumber, 145)
        XCTAssertEqual(warning.indent, 267)
    }

    func testAddLine() {
        let warning = FileWarning(firstLine:"e/ExistingClassCovered.swift:15:26: warning: 'index(of:)' is deprecated")
        warning.add(line: "if let index = s.index(of: \"a\") {")
        warning.add(line: "               ^")
        XCTAssertEqual(warning.details.count, 2)
        XCTAssertEqual(warning.details[0], "if let index = s.index(of: \"a\") {")
        XCTAssertEqual(warning.details[1], "                          ^")
    }
}
