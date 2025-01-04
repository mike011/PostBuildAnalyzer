//
//  WarningViewTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2019-12-25.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Testing

@Suite struct WarningViewTests {
    @Test func fillRow() {
        var view = MockWarningView()
        view.fillRow(model: MockWarningModel())
        #expect(view.columns == ["S", "detailed descripton", "measured value"])
    }
}
