//
//  ArgumentsTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2019-12-29.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import XCTest

let MOCK_ARGUMENTS = Arguments(
    repoURL: "repo",
    branch: "branch",
    outputFolder: EXAMPLE_LOG_FOLDER,
    logFileName: EXAMPLE_LOG_FILE_NAME,
    baseURLPath: "http://a.b/",
    lintFileName: nil,
    buildTimeThresholdInMS: 0
)

class ArgumentsTests: XCTestCase {
    func testExample() throws {
        let jsonString = """
        {
        "repoURL": "https://github.com/mike011/PostBuildAnalyzer",
        "branch": "master",
        "outputFolder": "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/fastlane/test_output/",
        "logFileName": "Example-Example (Before).log",
        "baseURLPath": "https://mike011.github.io/CodeCoverageCompare/before/",
        "lintFileName": "lint.html",
        "buildTimeThresholdInMS": 200
        }
        """

        let data = jsonString.data(using: .utf8)!
        let args = try XCTUnwrap(JSONDecoder().decode(Arguments.self, from: data))
        XCTAssertEqual(args.repoURL, "https://github.com/mike011/PostBuildAnalyzer")
        XCTAssertEqual(args.branch, "master")
        XCTAssertEqual(args.outputFolder, "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/fastlane/test_output/")
        XCTAssertEqual(args.logFileName, "Example-Example (Before).log")
        XCTAssertEqual(args.baseURLPath, "https://mike011.github.io/CodeCoverageCompare/before/")
        XCTAssertEqual(args.lintFileName, "lint.html")
        XCTAssertEqual(args.buildTimeThresholdInMS, 200)
    }
    
    func testExampleNoLogFile() throws {
        let jsonString = """
        {
        "repoURL": "https://github.com/mike011/PostBuildAnalyzer",
        "branch": "master",
        "outputFolder": "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/fastlane/test_output/",
        "baseURLPath": "https://mike011.github.io/CodeCoverageCompare/before/",
        "lintFileName": "lint.html",
        "buildTimeThresholdInMS": 200
        }
        """

        let data = jsonString.data(using: .utf8)!
        let args = try XCTUnwrap(JSONDecoder().decode(Arguments.self, from: data))
        XCTAssertEqual(args.repoURL, "https://github.com/mike011/PostBuildAnalyzer")
        XCTAssertEqual(args.branch, "master")
        XCTAssertEqual(args.outputFolder, "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/fastlane/test_output/")
        XCTAssertEqual(args.baseURLPath, "https://mike011.github.io/CodeCoverageCompare/before/")
        XCTAssertEqual(args.lintFileName, "lint.html")
        XCTAssertEqual(args.buildTimeThresholdInMS, 200)
    }
    
    func testExampleNoBuildTime() throws {
        let jsonString = """
        {
        "repoURL": "https://github.com/mike011/PostBuildAnalyzer",
        "branch": "master",
        "outputFolder": "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/fastlane/test_output/",
        "baseURLPath": "https://mike011.github.io/CodeCoverageCompare/before/",
        "lintFileName": "lint.html"
        }
        """

        let data = jsonString.data(using: .utf8)!
        let args = try XCTUnwrap(JSONDecoder().decode(Arguments.self, from: data))
        XCTAssertEqual(args.repoURL, "https://github.com/mike011/PostBuildAnalyzer")
        XCTAssertEqual(args.branch, "master")
        XCTAssertEqual(args.outputFolder, "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/fastlane/test_output/")
        XCTAssertEqual(args.baseURLPath, "https://mike011.github.io/CodeCoverageCompare/before/")
        XCTAssertEqual(args.lintFileName, "lint.html")
    }
    
    func testExampleNoBaseURLPath() throws {
        let jsonString = """
        {
        "repoURL": "https://github.com/mike011/PostBuildAnalyzer",
        "branch": "master",
        "outputFolder": "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/fastlane/test_output/",
        "lintFileName": "lint.html"
        }
        """

        let data = jsonString.data(using: .utf8)!
        let args = try XCTUnwrap(JSONDecoder().decode(Arguments.self, from: data))
        XCTAssertEqual(args.repoURL, "https://github.com/mike011/PostBuildAnalyzer")
        XCTAssertEqual(args.branch, "master")
        XCTAssertEqual(args.outputFolder, "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/fastlane/test_output/")
        XCTAssertEqual(args.lintFileName, "lint.html")
    }
}
