//
//  SlowExpressionAnalyzerTests.swift
//  PostBuildAnalzyerTests
//
//  Created by Michael Charland on 2019-12-23.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import XCTest

class SlowExpressionAnalyzerTests: XCTestCase {
    func testASlowExpression() {
        var logFile = [String]()
        logFile.append("0.01ms\t /Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/Warnings.swift:11:7\tinitializer init()")
        let wa = PostBuildAnalzyer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile)
        XCTAssertFalse(wa.allWarnings.isEmpty)
    }

    func testASlowExpressionInvalidString() {
        var logFile = [String]()
        logFile.append("Not a slow expression")
        let wa = PostBuildAnalzyer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile)
        XCTAssertTrue(wa.allWarnings.isEmpty)
    }
}
