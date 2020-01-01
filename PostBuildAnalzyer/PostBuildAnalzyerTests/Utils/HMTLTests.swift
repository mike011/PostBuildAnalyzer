//
//  HMTLTests.swift
//  PostBuildAnalzyerTests
//
//  Created by Michael Charland on 2020-01-01.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import XCTest

class HMTLTests: XCTestCase {
    func testAHREF() {
        let url = URL(string: "http://a.b")!
        let actual = HTML.getAHREF(url: url, title: "title")
        XCTAssertEqual(actual, "<a href=\"http://a.b\">title</a>")
    }
}
