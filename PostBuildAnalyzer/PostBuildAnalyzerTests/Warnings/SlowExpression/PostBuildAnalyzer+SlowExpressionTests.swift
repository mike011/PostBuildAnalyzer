//
//  SlowExpressionAnalyzerTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2019-12-23.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import XCTest

class SlowExpressionAnalyzerTests: XCTestCase {
    func testASlowExpression() {
        var logFile = [String]()
        logFile.append("0.01ms\t /Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/Warnings.swift:11:7\tinitializer init()")
        let wa = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: [])
        XCTAssertFalse(wa.allWarnings.isEmpty)
    }

    func testASlowExpressionTwice() {
        var logFile = [String]()
        logFile.append("0.01ms\t /Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/Warnings.swift:11:7\tinitializer init()")
        logFile.append("0.01ms\t /Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/Warnings.swift:11:7\tinitializer init()")
        let wa = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: [])
        let slowExpressionController = wa.getWarningController() as? [SlowExpressionController]
        XCTAssertEqual(slowExpressionController?.count, 1)
        XCTAssertEqual(slowExpressionController![0].getTotalWarnings(), 0.02)
    }

    func testASlowExpressionTwiceFromWarning() {
        var logFile = [String]()
        logFile.append("/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/Warnings.swift:36:63: warning: expression took 2010ms to type-check (limit: 100ms)")
        logFile.append("/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/Warnings.swift:36:63: warning: expression took 2050ms to type-check (limit: 100ms)")
        let wa = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: [])
        let slowExpressionController = wa.getWarningController() as? [SlowExpressionController]
        XCTAssertEqual(slowExpressionController?.count, 1)
        XCTAssertEqual(slowExpressionController![0].getTotalWarnings(), 4060.0)
    }

    func testASlowExpressionInvalidString() {
        var logFile = [String]()
        logFile.append("Not a slow expression")
        let wa = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: [])
        XCTAssertTrue(wa.allWarnings.isEmpty)
    }
}
