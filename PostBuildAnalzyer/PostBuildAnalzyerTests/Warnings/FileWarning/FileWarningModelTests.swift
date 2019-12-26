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
        let warning = FileWarningModel(repoURL: "https://github.com/mike011/PostBuildAnalyzer", branch: "master", firstLine: description)
        XCTAssertEqual(warning.url?.absoluteString, "https://github.com/mike011/PostBuildAnalyzer/blob/master/example/Before/Example/ExistingClassCovered.swift#L15")
        XCTAssertEqual(warning.lineNumber, 15)
        XCTAssertEqual(warning.description, "'index(of:)' is deprecated: renamed to 'firstIndex(of:)'")
        XCTAssertTrue(warning.details.isEmpty)
        XCTAssertEqual(warning.count, 1)
    }

    func testWarningSingleDigitNumbers() {
        let description = "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/ExistingClassCovered.swift:1:2: warning: 'index(of:)' is deprecated: renamed to 'firstIndex(of:)'"
        let warning = FileWarningModel(repoURL: "", branch: "", firstLine: description)
        XCTAssertEqual(warning.lineNumber, 1)
    }

    func testWarningTripleDigitNumbers() {
        let description = "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/ExistingClassCovered.swift:145:267: warning: 'index(of:)' is deprecated: renamed to 'firstIndex(of:)'"
        let warning = FileWarningModel(repoURL: "", branch: "", firstLine: description)
        XCTAssertEqual(warning.lineNumber, 145)
    }

    func getSampleWarning() -> FileWarningModel {
        let warning = FileWarningModel(repoURL: "https://github.com/mike011/PostBuildAnalyzer", branch: "master", firstLine: "Documents/git/PostBuildAnalyzer/example/Before/Example/ExistingClassCovered.swift:15:26: warning: 'index(of:)' is deprecated")
        warning.add(line: "if let index = s.index(of: \"a\") {")
        warning.add(line: "               ^")
        return warning
    }

    func getAnotherSampleWarning() -> FileWarningModel {
        let warning = FileWarningModel(repoURL: "", branch: "", firstLine: "Documents/git/PostBuildAnalyzer/example/Before/Example/Frank.swift:16:15: warning: result of call to 'substring(to:)' is unused")
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

    func testGetFileName() {
        let warning = FileWarningModel(repoURL: "", branch: "", firstLine: "/Users/distiller/project/example/Before/Example/ExistingClassCovered.swift:15:26: warning: 'index(of:)' is deprecated")
        XCTAssertEqual(warning.getFilename(), "ExistingClassCovered.swift")
    }

    func testGetURL() {
        let warning = getSampleWarning()
        XCTAssertEqual(warning.url?.absoluteString, "https://github.com/mike011/PostBuildAnalyzer/blob/master/example/Before/Example/ExistingClassCovered.swift#L15")
    }

    func testGetURLCircleFolder() {
        let warning = FileWarningModel(repoURL: "https://github.com/mike011/PostBuildAnalyzer", branch: "master", firstLine: "/Users/distiller/project/example/Before/Example/ExistingClassCovered.swift:15:26: warning: 'index(of:)' is deprecated")
        XCTAssertEqual(warning.url?.absoluteString, "https://github.com/mike011/PostBuildAnalyzer/blob/master/example/Before/Example/ExistingClassCovered.swift#L15")
    }

    func testGetRepo() {
        XCTAssertEqual(FileWarningModel.getRepoName(fromRepoURL: "junk"), "junk")
        XCTAssertEqual(FileWarningModel.getRepoName(fromRepoURL: "https://github.com/mike011/PostBuildAnalyzer"), "PostBuildAnalyzer")
    }
}
