//
//  LinkerWarningModelTests.swift
//  PostBuildAnalzyerTests
//
//  Created by Michael Charland on 2019-12-25.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import XCTest

class LinkerWarningModelTests: XCTestCase {
    func testSymbol() {
        let warning = LinkerWarningView()
        XCTAssertEqual(warning.symbol, "🚨")
    }

    func testDetailedDescripiton() {
        let warning = LinkerWarningView()
        let model = LinkerWarningModel(description: "ld: warning: directory not found for option")
        XCTAssertEqual(warning.getDetailedDescription(model: model), "directory not found for option")
    }

    func testMeasuredValue() {
        let warning = LinkerWarningView()
        let model = LinkerWarningModel(description: "")
        XCTAssertEqual(warning.getMeasuredValue(model: model), "1 times")
    }
}
