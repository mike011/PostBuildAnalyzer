//
//  LinkerWarningTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2019-12-20.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Testing

@Suite struct LinkerWarningTests {
    @Test func linkerWarning() {
        let warning = LinkerWarningModel(line: "ld: warning: directory not found for option '-F/Users/distiller/project/application/Personal/Personal/Features/SDKs/BOB'")
        #expect(warning.description == "directory not found for option '-F/Users/distiller/project/application/Personal/Personal/Features/SDKs/BOB'")
    }
}
