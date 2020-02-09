//
//  FileWarningModelTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2019-12-20.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import XCTest

class FileWarningModelTests: XCTestCase {
    func testWarning() {
        let description = "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/ExistingClassCovered.swift:15:26: warning: 'index(of:)' is deprecated: renamed to 'firstIndex(of:)'"
        let warning = FileWarningModel(repoURL: "https://github.com/mike011/PostBuildAnalyzer", branch: "master", line: description)
        XCTAssertEqual(warning.url?.absoluteString, "https://github.com/mike011/PostBuildAnalyzer/blob/master/example/Before/Example/ExistingClassCovered.swift#L15")
        XCTAssertEqual(warning.lineNumber, 15)
        XCTAssertEqual(warning.description, "'index(of:)' is deprecated: renamed to 'firstIndex(of:)'")
    }

    func testWarningSingleDigitNumbers() {
        let description = "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/ExistingClassCovered.swift:1:2: warning: 'index(of:)' is deprecated: renamed to 'firstIndex(of:)'"
        let warning = FileWarningModel(repoURL: "", branch: "", line: description)
        XCTAssertEqual(warning.lineNumber, 1)
    }

    func testWarningTripleDigitNumbers() {
        let description = "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/ExistingClassCovered.swift:145:267: warning: 'index(of:)' is deprecated: renamed to 'firstIndex(of:)'"
        let warning = FileWarningModel(repoURL: "", branch: "", line: description)
        XCTAssertEqual(warning.lineNumber, 145)
    }

    func getSampleWarning() -> FileWarningModel {
        let warning = FileWarningModel(repoURL: "https://github.com/mike011/PostBuildAnalyzer", branch: "master", line: "Documents/git/PostBuildAnalyzer/example/Before/Example/ExistingClassCovered.swift:15:26: warning: 'index(of:)' is deprecated")
        return warning
    }

    func getAnotherSampleWarning() -> FileWarningModel {
        let warning = FileWarningModel(repoURL: "", branch: "", line: "Documents/git/PostBuildAnalyzer/example/Before/Example/Frank.swift:16:15: warning: result of call to 'substring(to:)' is unused")
        warning.count = 2
        return warning
    }

    func testGetFileName() {
        let warning = FileWarningModel(repoURL: "", branch: "", line: "/Users/distiller/project/example/Before/Example/ExistingClassCovered.swift:15:26: warning: 'index(of:)' is deprecated")
        XCTAssertEqual(warning.getFilename(), "ExistingClassCovered.swift")
    }

    func testGetURL() {
        let warning = getSampleWarning()
        XCTAssertEqual(warning.url?.absoluteString, "https://github.com/mike011/PostBuildAnalyzer/blob/master/example/Before/Example/ExistingClassCovered.swift#L15")
    }

    func testGetURLCircleFolder() {
        let warning = FileWarningModel(repoURL: "https://github.com/mike011/PostBuildAnalyzer", branch: "master", line: "/Users/distiller/project/example/Before/Example/ExistingClassCovered.swift:15:26: warning: 'index(of:)' is deprecated")
        XCTAssertEqual(warning.url?.absoluteString, "https://github.com/mike011/PostBuildAnalyzer/blob/master/example/Before/Example/ExistingClassCovered.swift#L15")
    }

    func testGetRepo() {
        XCTAssertEqual(FileWarningModel.getRepoName(fromRepoURL: "junk"), "junk")
        XCTAssertEqual(FileWarningModel.getRepoName(fromRepoURL: "https://github.com/mike011/PostBuildAnalyzer"), "PostBuildAnalyzer")
    }

    func testInitWithFile() {
        let warning = FileWarningModel(repoURL: "http://a.c/repo", branch: "b", line: "repo/file: warning: error")
        XCTAssertEqual(warning.file, "file")
        XCTAssertEqual(warning.url?.absoluteString, "http://a.c/repo/blob/b/file")
        XCTAssertNil(warning.lineNumber)
        XCTAssertEqual(warning.description, "error")
    }

    func testInitWithFileWithLine() {
        let warning = FileWarningModel(repoURL: "http://a.c/repo", branch: "b", line: "repo/file:1:2: warning: error")
        XCTAssertEqual(warning.file, "file")
        XCTAssertEqual(warning.url?.absoluteString, "http://a.c/repo/blob/b/file#L1")
        XCTAssertEqual(warning.lineNumber, 1)
        XCTAssertEqual(warning.description, "error")
    }

    func testInitWithCoreData() {
        let line = "/Users/distiller/project/application/A/A/Core Data/A.xcdatamodeld/A 6.1.4.xcdatamodel:TMOAccountInfo.premiumState: warning: error"
        let warning = FileWarningModel(repoURL: "http://a.c/A", branch: "b", line: line)
        XCTAssertEqual(warning.file, "A/Core Data/A.xcdatamodeld/A 6.1.4.xcdatamodel:TMOAccountInfo.premiumState")
        XCTAssertNil(warning.lineNumber)
        XCTAssertEqual(warning.description, "error")
    }
}
