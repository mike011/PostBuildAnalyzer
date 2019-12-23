//
//  SlowExpressionAnalyzerTests.swift
//  PostBuildAnalzyerTests
//
//  Created by Michael Charland on 2019-12-23.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import XCTest

class SlowExpressionAnalyzerTests: XCTestCase {
    func SKIPtestNotASlowExpression() {
        var logFile = [String]()
        logFile.append("Not a slow expression")
        let wa = SlowExpressionAnalyzer(timeInMS: 0, logFile: logFile)
        XCTAssertTrue(wa.warnings.isEmpty)
    }

    func SKIPtestASlowExpression() {
        var logFile = [String]()
        logFile.append("5.34ms")
        let wa = SlowExpressionAnalyzer(timeInMS: 0, logFile: logFile)
        XCTAssertFalse(wa.warnings.isEmpty)
    }
}
