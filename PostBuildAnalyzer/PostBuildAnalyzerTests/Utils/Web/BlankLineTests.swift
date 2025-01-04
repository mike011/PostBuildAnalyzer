//
//  BlankLineTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2020-01-10.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import Testing

@Suite struct BlankLineTests {
    private let blankLine = BlankLine()

    @Test func toHTML() {
        #expect(blankLine.toHTML() == [" "])
    }

    @Test func toMarkdown() {
        #expect(blankLine.toMarkdown() == [" "])
    }
}
