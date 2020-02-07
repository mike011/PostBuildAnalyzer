//
//  URLParserTests.swift
//  PostBuildAnalzyerTests
//
//  Created by Michael Charland on 2019-12-25.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import XCTest

class TestParser: URLParser {}

class URLParserTests: XCTestCase {
    func testGetURLRealLifeExample() {
        let line = "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/ExistingClassCovered.swift"
        let url = TestParser.getURL(file: line, lineNumber: 15, repoURL: "https://github.com/mike011/PostBuildAnalyzer", branch: "master")
        XCTAssertEqual(url, URL(string: "https://github.com/mike011/PostBuildAnalyzer/blob/master/example/Before/Example/ExistingClassCovered.swift#L15"))
    }

    func testGetRepoPath() {
        XCTAssertEqual(TestParser.getRepoName(fromRepoURL: "NO_SLASHES"), "NO_SLASHES")
        XCTAssertEqual(TestParser.getRepoName(fromRepoURL: "a/b/c"), "c")
    }

    func testGetPath() {
        XCTAssertEqual(TestParser.getPath(file: "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/ExistingClassCovered.swift", repoName: "PostBuildAnalyzer"), "example/Before/Example/ExistingClassCovered.swift")
    }

    func testGetPathCircle() {
        XCTAssertEqual(TestParser.getPath(file: "/Users/distiller/project/example/Before/Example/ExistingClassCovered.swift", repoName: ""), "example/Before/Example/ExistingClassCovered.swift")
    }

    func testGetPathNotParsedInvalidFolder() {
        let line = "/Users/project/example/Before/Example/ExistingClassCovered.swift"
        let url = TestParser.getPath(file: line, repoName: "")
        XCTAssertEqual(url, line)
    }

    func testGetPathNotParsedNoColon() {
        let line = "/Users/project/example/Before/Example/ExistingClassCovered.swift"
        let url = TestParser.getPath(file: line, repoName: "")
        XCTAssertEqual(url, line)
    }

    func testGetLineNumber() {
        XCTAssertEqual(TestParser.getLineNumber(line: "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/ExistingClassCovered.swift:15:11"), 15)
    }

    func testGetLineNumberNoStartColon() {
        XCTAssertNil(TestParser.getLineNumber(line: "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/ExistingClassCovered.swift"))
    }

    func testGetLineNumberNoEndColon() {
        XCTAssertNil(TestParser.getLineNumber(line: "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/ExistingClassCovered.swift:1"))
    }
}
