//
//  LDWarningTests.swift
//  PostBuildAnalzyerTests
//
//  Created by Michael Charland on 2019-12-20.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import XCTest

class LDWarningTests: XCTestCase {
    func testLDWarning() {
        let warning = LDWarning(description: "ld: warning: directory not found for option '-F/Users/distiller/project/application/Personal/Personal/Features/SDKs/BOB'")
        XCTAssertEqual(warning.description, "directory not found for option '-F/Users/distiller/project/application/Personal/Personal/Features/SDKs/BOB'")
    }

    func testSymbol() {
        let warning = LDWarning(description: "")
        XCTAssertEqual(warning.symbol, "⚠️")
    }

    func testDetailedDescripiton() {
        let warning = LDWarning(description: "ld: warning: description")
        XCTAssertEqual(warning.detailedDescripiton, "description")
    }

    func testMeasuredValue() {
        let warning = LDWarning(description: "")
        XCTAssertEqual(warning.measuredValue, "1 times")
    }
}
