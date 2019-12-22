//
//  WarningTests.swift
//  PostBuildAnalzyerTests
//
//  Created by Michael Charland on 2019-12-21.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import XCTest

private class TestWarning: Warning {
    static var lookFor = "lookFor"
    var description = "description"
    var count = 1

    func getFirstColumn() -> String {
        return "A"
    }

    func getSecondColumn() -> String {
        return "B"
    }

    func getThirdColumn() -> String {
        return "C"
    }
}

class WarningTests: XCTestCase {

    func testToHTML() {
        let warning = TestWarning()
        XCTAssertEqual(warning.toHTML(), "|A|B|C|")
    }
}
