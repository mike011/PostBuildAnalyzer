//
//  PostBuildAnalyzer+LinkerWarningControllerTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2020-02-28.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import XCTest

class PostBuildAnalyzerLinkerWarningControllerTests: XCTestCase {
    func testIsLinkerWarning() {
        XCTAssertTrue(
            PostBuildAnalyzer.isLinkerWarning(
                line: "Serializer.swift:98:63: ld: warning: Kablooey"
            )
        )
    }

    func testIsLinkerWarningFalse() {
        XCTAssertFalse(
            PostBuildAnalyzer.isLinkerWarning(
                line: "Serializer.swift:98:63: warning: expression took 108ms to type-check (limit: 100ms)"
            )
        )
    }
}
