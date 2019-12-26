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
        let fileWarning = "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/ExistingClassCovered.swift:15:26: warning: 'index(of:)' is deprecated: renamed to 'firstIndex(of:)'"
        let url = TestParser.getURL(from: fileWarning, repoURL: "https://github.com/mike011/PostBuildAnalyzer", branch: "master")
        XCTAssertEqual(url, URL(string: "https://github.com/mike011/PostBuildAnalyzer/blob/master/example/Before/Example/ExistingClassCovered.swift#L15"))
    }

    func testGetURLNoColons() {
        let fileWarning = "No colons"
        let url = TestParser.getURL(from: fileWarning, repoURL: "https://github.com/mike011/PostBuildAnalyzer", branch: "master")
        XCTAssertNil(url)
    }

    func testGetRepoPath() {
        XCTAssertEqual(TestParser.getRepoName(fromRepoURL: "NO_SLASHES"), "NO_SLASHES")
        XCTAssertEqual(TestParser.getRepoName(fromRepoURL: "a/b/c"), "c")
    }

    func testGetPath() {
        XCTAssertEqual(TestParser.getPath(line: "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/ExistingClassCovered.swift:15", repoName: "PostBuildAnalyzer"), "example/Before/Example/ExistingClassCovered.swift")
    }

    func testGetPathCircle() {
        XCTAssertEqual(TestParser.getPath(line: "/Users/distiller/project/example/Before/Example/ExistingClassCovered.swift:15", repoName: ""), "example/Before/Example/ExistingClassCovered.swift")
    }

    func testGetPathNotParsedInvalidFolder() {
        XCTAssertNil(TestParser.getPath(line: "/Users/project/example/Before/Example/ExistingClassCovered.swift:15", repoName: ""))
    }

    func testGetPathNotParsedNoColon() {
        XCTAssertNil(TestParser.getPath(line: "/Users/project/example/Before/Example/ExistingClassCovered.swift", repoName: ""))
    }

    func testGetLineNumber() {
        XCTAssertEqual(TestParser.getLineNumber(line: "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/ExistingClassCovered.swift:15:"), 15)
    }

    func testGetLineNumberNoStartColon() {
        XCTAssertNil(TestParser.getLineNumber(line: "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/ExistingClassCovered.swift"))
    }

    func testGetLineNumberNoEndColon() {
        XCTAssertNil(TestParser.getLineNumber(line: "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/ExistingClassCovered.swift:1"))
    }
}
