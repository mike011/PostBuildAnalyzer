//
//  WarningModelTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2020-02-28.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import Testing

@Suite struct WarningModelTests {
    @Test func compareToSame() {
        let model = MockWarningModel()
        #expect(model.compareTo(line: ""))
    }

    @Test func compareToDifferent() {
        let model = MockWarningModel()
        #expect(!model.compareTo(line: "different"))
    }
}
