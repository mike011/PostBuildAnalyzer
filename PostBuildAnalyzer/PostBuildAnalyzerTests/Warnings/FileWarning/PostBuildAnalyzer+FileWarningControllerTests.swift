//
//  FileWarningControllerTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2020-02-28.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import Testing

@Suite struct FileWarningControllerTests {
    @Test func isFileWarning() {
        #expect(PostBuildAnalyzer.isFileWarning(
                line: "Serializer.swift:98:63: warning: Kablooey"
            )
        )
    }

    @Test() func isFileWarningSlowCompileTime() {
        #expect(!PostBuildAnalyzer.isFileWarning(
                line: "Serializer.swift:98:63: warning: expression took 108ms to type-check (limit: 100ms)"
            )
        )
    }
}
