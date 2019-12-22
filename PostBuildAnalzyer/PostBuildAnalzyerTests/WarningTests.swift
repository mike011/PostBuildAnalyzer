//
//  WarningTests.swift
//  PostBuildAnalzyerTests
//
//  Created by Michael Charland on 2019-12-21.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import XCTest

private class TestWarning: Warning {
    var symbol = "Symbol"
    var detaledDescripiton = "Detailed Description"
    var measuredValue = "Measured Value"

    static var lookFor = "lookFor"
    var description = "description"
    var count = 1
}

class WarningTests: XCTestCase {
    func testToHTML() {
        let warning = TestWarning()
        XCTAssertEqual(warning.toHTML(), "|Symbol|Detailed Description|Measured Value|")
    }
}
