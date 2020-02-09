//
//  WarningViewTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2019-12-25.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import XCTest

class WarningViewTests: XCTestCase {
    func testFillRow() {
        var view = MockWarningView()
        view.fillRow(model: MockWarningModel())
        XCTAssertEqual(view.columns, ["S", "detailed descripton", "measured value"])
    }
}
