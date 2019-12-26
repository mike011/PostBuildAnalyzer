//
//  SlowExpressionControllerTests.swift
//  PostBuildAnalzyerTests
//
//  Created by Michael Charland on 2019-12-26.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import XCTest

class SlowExpressionControllerTests: XCTestCase {
    func testIsSlowExpressionFileCompiledBelowThreshold() {
        XCTAssertFalse(PostBuildAnalzyer.isSlowExpression(line: "0.94ms", minimumTimeInMS: 1.00))
    }

    func testIsSlowExpressionFileCompiledAboveThreshold() {
        XCTAssertTrue(PostBuildAnalzyer.isSlowExpression(line: "0.94ms", minimumTimeInMS: 0.90))
    }

    func testIsSlowExpressionInvalidFile() {
        XCTAssertFalse(PostBuildAnalzyer.isSlowExpression(line: "Invalid String", minimumTimeInMS: 1.00))
    }

    func testIsSlowExpressionInvalidLocation() {
        XCTAssertFalse(PostBuildAnalzyer.isSlowExpression(line: "0.94ms invalid loc", minimumTimeInMS: 0.90))
    }
}
