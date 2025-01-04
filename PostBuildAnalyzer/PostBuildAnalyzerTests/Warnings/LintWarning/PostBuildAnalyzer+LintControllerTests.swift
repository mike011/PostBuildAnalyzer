//
//  PostBuildAnalyzer+LintControllerTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2020-02-28.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import Testing

@Suite struct PostBuildAnalyzerLintControllerTests {
    @Test func isLinkerWarning() {
        #expect(
            PostBuildAnalyzer.isLintWarning(
                line: "<td class=\"warning\">Warning</td>"
            )
        )
    }

    @Test func isLinkerWarningFalse() {
        #expect(
            !PostBuildAnalyzer.isLintWarning(
                line: "<td class=\"error\">Error</td>"
            )
        )
    }
}
