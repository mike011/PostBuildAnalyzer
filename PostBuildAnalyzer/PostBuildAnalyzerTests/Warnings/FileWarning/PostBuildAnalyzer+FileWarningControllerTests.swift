//
//  FileWarningControllerTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2020-02-28.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import XCTest

class FileWarningControllerTests: XCTestCase {
    func testIsFileWarning() {
        XCTAssertTrue(
            PostBuildAnalyzer.isFileWarning(
                line: "Serializer.swift:98:63: warning: Kablooey"
            )
        )
    }

    func testIsFileWarningSlowCompileTime() {
        XCTAssertFalse(
            PostBuildAnalyzer.isFileWarning(
                line: "Serializer.swift:98:63: warning: expression took 108ms to type-check (limit: 100ms)"
            )
        )
    }
}
