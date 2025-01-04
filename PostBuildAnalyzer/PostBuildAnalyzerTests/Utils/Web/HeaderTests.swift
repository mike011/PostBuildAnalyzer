//
//  HeaderTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2020-01-10.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import Testing

@Suite struct HeaderTests {
    private let header = Header(level: 2, title: "title")

    @Test func toHTML() {
        #expect(header.toHTML() == ["<H2>title</H2>"])
    }

    @Test func toMarkdown() {
        #expect(header.toMarkdown() == ["<H2>title</H2>"])

        let header4 = Header(level: 4, title: "monkey")
        #expect(header4.toMarkdown() == ["<H4>monkey</H4>"])
    }
}
