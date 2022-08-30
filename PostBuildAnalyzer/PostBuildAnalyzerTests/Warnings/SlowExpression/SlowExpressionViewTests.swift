//
//  SlowExpressionViewTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2019-12-26.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import XCTest

class SlowExpressionViewTests: XCTestCase {
    func testSymbol() {
        let warning = SlowExpressionView()
        XCTAssertEqual(warning.symbol, "⏱")
    }

    func testDetailedDescription() {
        let warning = SlowExpressionView()
        let model = SlowExpressionModel(repoURL: "http://w.a/repo", branch: "b", line: "0.01ms\t /Users/michael/Documents/git/repo/example/Before/Example/ExistingClassCovered.swift:11:7\tmethod initializer init()")
        let ahref = "<a href=\"http://w.a/repo/blob/b/example/Before/Example/ExistingClassCovered.swift#L11\">ExistingClassCovered.swift</a>"
        XCTAssertEqual(warning.getDetailedDescription(model: model), "\(ahref) on line 11 method initializer init()")
    }

    func testMeasuredValue() {
        let warning = SlowExpressionView()
        let model = SlowExpressionModel(repoURL: "", branch: "", line: "0.94ms\t /Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/Warnings.swift:11:7\tinitializer init()")
        XCTAssertEqual(warning.getMeasuredValue(model: model), "0.94ms")
    }

    func testMeasuredValueFormatted() {
        let warning = SlowExpressionView()
        let model = SlowExpressionModel(repoURL: "", branch: "", line: "0.99ms\ta\tb")
        model.timeInMS = 0.3242343232232
        XCTAssertEqual(warning.getMeasuredValue(model: model), "0.32ms")
    }
}
