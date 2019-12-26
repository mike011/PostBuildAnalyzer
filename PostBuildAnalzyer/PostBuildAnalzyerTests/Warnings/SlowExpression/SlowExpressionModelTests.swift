//
//  SlowExpressionModelTests.swift
//  PostBuildAnalzyerTests
//
//  Created by Michael Charland on 2019-12-26.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import XCTest

class SlowExpressionModelTests: XCTestCase {
    private let slowExpression = SlowExpressionModel(repoURL: "", branch: "", line: "0.94ms\t /Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/Warnings.swift:19:10\tinstance method secondWarning()")

    func testCount() {
        XCTAssertEqual(slowExpression.count, 1)
    }

    func testTimeInMS() {
        XCTAssertEqual(slowExpression.timeInMS, 0.94)
    }

    func testFile() {
        XCTAssertEqual(slowExpression.file, "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/Warnings.swift")
    }

    func testDescription() {
        XCTAssertEqual(slowExpression.description, "instance method secondWarning()")
    }
}
