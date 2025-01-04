//
//  HMTLTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2020-01-01.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import Foundation
import Testing

@Suite struct HMTLTests {
    @Test func aHREF() {
        let url = URL(string: "http://a.b")!
        let actual = HTML.getAHREF(url: url, title: "title")
        #expect(actual == "<a href=\"http://a.b\">title</a>")
    }
}
