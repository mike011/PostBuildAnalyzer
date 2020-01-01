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
        let model = TestWarningModel()
        model.line = "LINE"
        let controller = WarningController(model: model, view: TestWarningView())
        let controller2 = WarningController(model: TestWarningModel(), view: TestWarningView())

        XCTAssertNotEqual(controller, controller2)
    }

    func testEqualsSame() {
        let controller = WarningController(model: TestWarningModel(), view: TestWarningView())
        let controller2 = WarningController(model: TestWarningModel(), view: TestWarningView())

        XCTAssertEqual(controller, controller2)
    }

    func testPrintView() {
        let controller = WarningController(model: TestWarningModel(), view: TestWarningView())
        XCTAssertEqual(controller.printView(), "|S|detailed descripton|measured value|")
    }

    func testAmountOfWarnings() {
        let controller = WarningController(model: TestWarningModel(), view: TestWarningView())
        XCTAssertEqual(controller.getTotalWarnings(), 1)
        controller.addDuplicate()
        XCTAssertEqual(controller.getTotalWarnings(), 2)
    }

    func testHash() {
        let controller = WarningController(model: TestWarningModel(), view: TestWarningView())
        var hasherBefore = Hasher().finalize()
        var hasher = Hasher()
        controller.hash(into: &hasher)
        XCTAssertNotEqual(hasherBefore, hasher.finalize())
    }
}
