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
        XCTAssertTrue(pba.fileWarningController.isEmpty)
        XCTAssertTrue(pba.linkerController.isEmpty)
        XCTAssertTrue(pba.slowExpressionController.isEmpty)
        XCTAssertTrue(pba.rows.isEmpty)
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
        XCTAssertFalse(pba.fileWarningController.isEmpty)
        XCTAssertTrue(pba.linkerController.isEmpty)
        XCTAssertTrue(pba.slowExpressionController.isEmpty)
        XCTAssertFalse(pba.rows.isEmpty)
    }
}
