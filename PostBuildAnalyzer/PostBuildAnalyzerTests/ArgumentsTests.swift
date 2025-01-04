//
//  ArgumentsTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2019-12-29.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation
import Testing

let MOCK_ARGUMENTS = Arguments(
    repoURL: "repo",
    branch: "branch",
    outputFolder: EXAMPLE_LOG_FOLDER,
    logFileName: EXAMPLE_LOG_FILE_NAME,
    baseURLPath: "http://a.b/",
    lintFileName: nil,
    buildTimeThresholdInMS: 0,
    ignorePaths: ["Pods"]
)

@Suite struct ArgumentsTests {
    @Test func example() throws {
        let jsonString = """
        {
        "repoURL": "https://github.com/mike011/PostBuildAnalyzer",
        "branch": "master",
        "outputFolder": "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/fastlane/test_output/",
        "logFileName": "Example-Example (Before).log",
        "baseURLPath": "https://mike011.github.io/CodeCoverageCompare/before/",
        "lintFileName": "lint.html",
        "buildTimeThresholdInMS": 200,
        "ignorePaths": ["Pods"]
        }
        """

        let data = jsonString.data(using: .utf8)!
        let args = try JSONDecoder().decode(Arguments.self, from: data)
        #expect(args.repoURL == "https://github.com/mike011/PostBuildAnalyzer")
        #expect(args.branch == "master")
        #expect(args.outputFolder == "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/fastlane/test_output/")
        #expect(args.logFileName == "Example-Example (Before).log")
        #expect(args.baseURLPath == "https://mike011.github.io/CodeCoverageCompare/before/")
        #expect(args.lintFileName == "lint.html")
        #expect(args.buildTimeThresholdInMS == 200)
        #expect(args.ignorePaths == ["Pods"])
    }
    
    @Test func exampleNoLogFile() throws {
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
        let args = try JSONDecoder().decode(Arguments.self, from: data)
        #expect(args.repoURL == "https://github.com/mike011/PostBuildAnalyzer")
        #expect(args.branch == "master")
        #expect(args.outputFolder == "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/fastlane/test_output/")
        #expect(args.baseURLPath == "https://mike011.github.io/CodeCoverageCompare/before/")
        #expect(args.lintFileName == "lint.html")
        #expect(args.buildTimeThresholdInMS == 200)
    }
    
    @Test func exampleNoBuildTime() throws {
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
        let args = try JSONDecoder().decode(Arguments.self, from: data)
        #expect(args.repoURL == "https://github.com/mike011/PostBuildAnalyzer")
        #expect(args.branch == "master")
        #expect(args.outputFolder == "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/fastlane/test_output/")
        #expect(args.baseURLPath == "https://mike011.github.io/CodeCoverageCompare/before/")
        #expect(args.lintFileName == "lint.html")
    }
    
    @Test func exampleNoBaseURLPath() throws {
        let jsonString = """
        {
        "repoURL": "https://github.com/mike011/PostBuildAnalyzer",
        "branch": "master",
        "outputFolder": "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/fastlane/test_output/",
        "lintFileName": "lint.html"
        }
        """

        let data = jsonString.data(using: .utf8)!
        let args = try JSONDecoder().decode(Arguments.self, from: data)
        #expect(args.repoURL == "https://github.com/mike011/PostBuildAnalyzer")
        #expect(args.branch == "master")
        #expect(args.outputFolder == "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/fastlane/test_output/")
        #expect(args.lintFileName == "lint.html")
    }
}
