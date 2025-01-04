//
//  WarningControllerTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2019-12-25.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Testing

@Suite struct WarningControllerTests {
    @Test func equalsDifferent() {
        let model = MockWarningModel()
        model.line = "LINE"
        let controller = WarningController(model: model, view: MockWarningView())
        let controller2 = WarningController(model: MockWarningModel(), view: MockWarningView())

        #expect(controller != controller2)
    }

    @Test func equalsSame() {
        let controller = WarningController(model: MockWarningModel(), view: MockWarningView())
        let controller2 = WarningController(model: MockWarningModel(), view: MockWarningView())

        #expect(controller == controller2)
    }

    @Test func amountOfWarnings() {
        let controller = WarningController(model: MockWarningModel(), view: MockWarningView())
        #expect(controller.getTotalWarnings() == 1)
        controller.add(amount: 1)
        #expect(controller.getTotalWarnings() == 2)
    }

    @Test func hash() {
        let controller = WarningController(model: MockWarningModel(), view: MockWarningView())
        let hasherBefore = Hasher().finalize()
        var hasher = Hasher()
        controller.hash(into: &hasher)
        #expect(hasherBefore != hasher.finalize())
    }
}
