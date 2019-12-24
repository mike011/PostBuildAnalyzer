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
        let wa = SlowExpressionAnalyzer(timeInMS: 0, logFile: logFile)
        XCTAssertTrue(wa.warnings.isEmpty)
    }

    func testASlowExpression() {
        var logFile = [String]()
        logFile.append("0.01ms    <invalid loc>    initializer init()")
        let wa = SlowExpressionAnalyzer(timeInMS: 0, logFile: logFile)
        XCTAssertFalse(wa.warnings.isEmpty)
    }
}
