//
//  SlowExpressionAnalyzerTests.swift
//  PostBuildAnalzyerTests
//
//  Created by Michael Charland on 2019-12-23.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import XCTest

class SlowExpressionAnalyzerTests: XCTestCase {
    func testNotASlowExpression() {
        var logFile = [String]()
        logFile.append("Not a slow expression")
        let wa = PostBuildAnalzyer(repoURL: "", branch: "", minimumTimeInMS: 0, logFile: logFile, lintFile: [String]())
        XCTAssertTrue(wa.warnings.isEmpty)
    }

    func testASlowExpression() {
        var logFile = [String]()
        logFile.append("0.01ms    <invalid loc>    initializer init()")
        let wa = PostBuildAnalzyer(repoURL: "", branch: "", minimumTimeInMS: 0, logFile: logFile, lintFile: [String]())
        XCTAssertFalse(wa.warnings.isEmpty)
    }
}
