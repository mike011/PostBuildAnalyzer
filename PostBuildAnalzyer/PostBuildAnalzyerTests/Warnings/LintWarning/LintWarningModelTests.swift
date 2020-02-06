//
//  LintWarningModelTests.swift
//  PostBuildAnalzyerTests
//
//  Created by Michael Charland on 2020-02-05.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import XCTest

class LintWarningModelTests: XCTestCase {
    func testSymbol() {
        let warning = LintWarningView()
        XCTAssertEqual(warning.symbol, "🧽")
    }

    func testDetailedDescripiton() {
        let warning = LintWarningView()
        let model = LintWarningModel(line: "                    <td>Collection literals should not have trailing commas.</td>")
        XCTAssertEqual(warning.getDetailedDescription(model: model), "Collection literals should not have trailing commas.")
    }

    func testMeasuredValue() {
        let warning = LintWarningView()
        let model = LintWarningModel(line: "")
        XCTAssertEqual(warning.getMeasuredValue(model: model), "1 times")
    }
}
