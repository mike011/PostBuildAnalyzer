//
//  PostBuildAnalyzer+LintControllerTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2020-02-28.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import XCTest

class PostBuildAnalyzerLintControllerTests: XCTestCase {
    func testIsLinkerWarning() {
        XCTAssertTrue(
            PostBuildAnalyzer.isLintWarning(
                line: "<td class=\"warning\">Warning</td>"
            )
        )
    }

    func testIsLinkerWarningFalse() {
        XCTAssertFalse(
            PostBuildAnalyzer.isLintWarning(
                line: "<td class=\"error\">Error</td>"
            )
        )
    }
}
