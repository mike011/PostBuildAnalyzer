//
//  PostBuildAnalyzer+SlowExpressionControllerTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2020-02-28.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import Testing

@Suite struct PostBuildAnalyzerSlowExpressionControllerTests {
    @Test func isSlowExpressionFileCompiledBelowThreshold() {
        #expect(!PostBuildAnalyzer.isSlowExpression(line: "0.94ms", buildTimeThresholdInMS: 1.00))
    }

    @Test func isSlowExpressionFileCompiledAboveThreshold() {
        #expect(PostBuildAnalyzer.isSlowExpression(line: "0.94ms", buildTimeThresholdInMS: 0.90))
    }

    @Test func isSlowExpressionFromWarning() {
        #expect(
            PostBuildAnalyzer.isSlowExpression(
                line: "Serializer.swift:98:63: warning: expression took 108ms to type-check (limit: 100ms)",
                buildTimeThresholdInMS: 0.90
            )
        )
    }

    @Test func isSlowExpressionInvalidFile() {
        #expect(!PostBuildAnalyzer.isSlowExpression(line: "Invalid String", buildTimeThresholdInMS: 1.00))
    }

    @Test func isSlowExpressionInvalidLocation() {
        #expect(!PostBuildAnalyzer.isSlowExpression(line: "0.94ms invalid loc", buildTimeThresholdInMS: 0.90))
    }
}
