//
//  LinkerWarningTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2019-12-20.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import XCTest

class LinkerWarningTests: XCTestCase {
    func testLinkerWarning() {
        let warning = LinkerWarningModel(line: "ld: warning: directory not found for option '-F/Users/distiller/project/application/Personal/Personal/Features/SDKs/BOB'")
        XCTAssertEqual(warning.description, "directory not found for option '-F/Users/distiller/project/application/Personal/Personal/Features/SDKs/BOB'")
    }
}
