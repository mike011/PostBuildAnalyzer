//
//  LinkerWarningModelTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2019-12-25.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Testing

@Suite struct LinkerWarningModelTests {
    @Test func symbol() {
        let warning = LinkerWarningView()
        #expect(warning.symbol == "🚨")
    }

    @Test func detailedDescripiton() {
        let warning = LinkerWarningView()
        let model = LinkerWarningModel(line: "ld: warning: directory not found for option")
        #expect(warning.getDetailedDescription(model: model) == "directory not found for option")
    }

    @Test func measuredValue() {
        let warning = LinkerWarningView()
        let model = LinkerWarningModel(line: "")
        #expect(warning.getMeasuredValue(model: model) == "1 times")
    }
}
