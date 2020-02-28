//
//  PostBuildAnalyzer+SlowExpressionControllerTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2020-02-28.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import XCTest

class PostBuildAnalyzerSlowExpressionControllerTests: XCTestCase {
    func testIsSlowExpressionFileCompiledBelowThreshold() {
        XCTAssertFalse(PostBuildAnalyzer.isSlowExpression(line: "0.94ms", buildTimeThresholdInMS: 1.00))
    }

    func testIsSlowExpressionFileCompiledAboveThreshold() {
        XCTAssertTrue(PostBuildAnalyzer.isSlowExpression(line: "0.94ms", buildTimeThresholdInMS: 0.90))
    }

    func testIsSlowExpressionFromWarning() {
        XCTAssertTrue(
            PostBuildAnalyzer.isSlowExpression(
                line: "Serializer.swift:98:63: warning: expression took 108ms to type-check (limit: 100ms)",
                buildTimeThresholdInMS: 0.90
            )
        )
    }

    func testIsSlowExpressionInvalidFile() {
        XCTAssertFalse(PostBuildAnalyzer.isSlowExpression(line: "Invalid String", buildTimeThresholdInMS: 1.00))
    }

    func testIsSlowExpressionInvalidLocation() {
        XCTAssertFalse(PostBuildAnalyzer.isSlowExpression(line: "0.94ms invalid loc", buildTimeThresholdInMS: 0.90))
    }
}
