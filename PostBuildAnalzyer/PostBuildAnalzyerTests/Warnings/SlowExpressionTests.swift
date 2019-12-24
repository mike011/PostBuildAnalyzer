//
//  SlowExpressionTests.swift
//  PostBuildAnalzyerTests
//
//  Created by Michael Charland on 2019-12-24.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import XCTest

class SlowExpressionTests: XCTestCase {
    private let slowExpression = SlowExpression(line: "0.94ms    /Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/Warnings.swift:19:10    instance method secondWarning()")

    func testSymbol() {
        XCTAssertEqual(slowExpression.symbol, "⏱")
    }

    func testTimeInMS() {
        XCTAssertEqual(slowExpression.timeInMS, 0.94)
    }

    func testSlowExpression() {
        XCTAssertEqual(slowExpression.description, "instance method secondWarning()")
    }

    func testDetailedDescripiton() {
        XCTAssertEqual(slowExpression.detailedDescripiton, "description")
    }

    func testMeasuredValue() {
        XCTAssertEqual(slowExpression.measuredValue, "1 times")
    }
}
