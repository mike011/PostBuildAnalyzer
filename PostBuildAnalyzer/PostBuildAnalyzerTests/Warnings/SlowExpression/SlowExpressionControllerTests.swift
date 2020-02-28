//
//  SlowExpressionControllerTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2019-12-26.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import XCTest

class SlowExpressionControllerTests: XCTestCase {
    func testEquals() {
        let line = "41.38ms\t/Users/michael/Warnings.swift:12:10\tinstance method firstWarning()"
        let sec = SlowExpressionController(repoURL: "", branch: "", line: line)

        let line2 = "31.38ms\t/Users/michael/Warnings.swift:12:10\tinstance method firstWarning()"
        let sec2 = SlowExpressionController(repoURL: "", branch: "", line: line2)

        XCTAssertEqual(sec, sec2)
    }

    func testAmountOfWarnings() {
        let line = "41.38ms\t/Users/michael/Warnings.swift:12:10\tinstance method firstWarning()"
        let controller = SlowExpressionController(repoURL: "", branch: "", line: line)

        XCTAssertEqual(controller.getTotalWarnings(), 41.38)
        controller.add(amount: 58.62)
        XCTAssertEqual(controller.getTotalWarnings(), 100.00)
    }
}
