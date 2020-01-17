//
//  PostBuildAnalyzerTests.swift
//  PostBuildAnalzyerTests
//
//  Created by Michael Charland on 2019-12-31.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import XCTest

class PostBuildAnalyzerTests: XCTestCase {
    func testInitNoWarnings() {
        let args = Arguments(
            repoURL: "repo",
            branch: "branch",
            outputFolder: "output",
            logFileName: "log",
            baseURLPath: "base",
            lintFileName: nil,
            buildTimeThresholdInMS: 100
        )
        let pba = PostBuildAnalzyer(args: args)
        XCTAssertTrue(pba.allWarnings.isEmpty)
    }

    func testInitWarnings() {
        let args = Arguments(
            repoURL: "repo",
            branch: "master",
            outputFolder: EXAMPLE_LOG_FOLDER,
            logFileName: EXAMPLE_LOG_FILE_NAME,
            baseURLPath: "base",
            lintFileName: nil,
            buildTimeThresholdInMS: 100
        )
        let pba = PostBuildAnalzyer(args: args)
        XCTAssertFalse(pba.allWarnings.isEmpty)
    }

    func testInitWithDuplicateSlowExpression() {
        var logFile = [String]()
        logFile.append("41.38ms\t/Users/michael/Warnings.swift:12:10\tinstance method firstWarning()")
        logFile.append("31.38ms\t/Users/michael/Warnings.swift:12:10\tinstance method firstWarning()")
        let pba = PostBuildAnalzyer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile)
        let se = pba.getWarningController() as [SlowExpressionController]
        XCTAssertEqual(se.count, 1)
    }

    func testGetWarningControllerNoWarnings() {
        let args = Arguments(
            repoURL: "repo",
            branch: "branch",
            outputFolder: "output",
            logFileName: "log",
            baseURLPath: "base",
            lintFileName: nil,
            buildTimeThresholdInMS: 100
        )
        let pba = PostBuildAnalzyer(args: args)
        XCTAssertTrue((pba.getWarningController() as [FileWarningController]).isEmpty)
        XCTAssertTrue((pba.getWarningController() as [LinkerWarningController]).isEmpty)
        XCTAssertTrue((pba.getWarningController() as [SlowExpressionController]).isEmpty)
        XCTAssertTrue(pba.rows.isEmpty)
    }

    func testGetWarningControllerWithWarnings() {
        let args = Arguments(
            repoURL: "repo",
            branch: "master",
            outputFolder: EXAMPLE_LOG_FOLDER,
            logFileName: EXAMPLE_LOG_FILE_NAME,
            baseURLPath: "base",
            lintFileName: nil,
            buildTimeThresholdInMS: 100
        )
        let pba = PostBuildAnalzyer(args: args)
        XCTAssertFalse((pba.getWarningController() as [FileWarningController]).isEmpty)
        XCTAssertFalse((pba.getWarningController() as [LinkerWarningController]).isEmpty)
        XCTAssertTrue((pba.getWarningController() as [SlowExpressionController]).isEmpty)
        XCTAssertFalse(pba.rows.isEmpty)
    }
}
