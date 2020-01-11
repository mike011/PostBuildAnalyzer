//
//  WarningControllerTests.swift
//  PostBuildAnalzyerTests
//
//  Created by Michael Charland on 2019-12-25.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import XCTest

class WarningControllerTests: XCTestCase {
    func testEqualsDifferent() {
        let model = MockWarningModel()
        model.line = "LINE"
        let controller = WarningController(model: model, view: MockWarningView())
        let controller2 = WarningController(model: MockWarningModel(), view: MockWarningView())

        XCTAssertNotEqual(controller, controller2)
    }

    func testEqualsSame() {
        let controller = WarningController(model: MockWarningModel(), view: MockWarningView())
        let controller2 = WarningController(model: MockWarningModel(), view: MockWarningView())

        XCTAssertEqual(controller, controller2)
    }

    func testAmountOfWarnings() {
        let controller = WarningController(model: MockWarningModel(), view: MockWarningView())
        XCTAssertEqual(controller.getTotalWarnings(), 1)
        controller.addDuplicate()
        XCTAssertEqual(controller.getTotalWarnings(), 2)
    }

    func testHash() {
        let controller = WarningController(model: MockWarningModel(), view: MockWarningView())
        let hasherBefore = Hasher().finalize()
        var hasher = Hasher()
        controller.hash(into: &hasher)
        XCTAssertNotEqual(hasherBefore, hasher.finalize())
    }
}
