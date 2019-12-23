//
//  WarningTests.swift
//  PostBuildAnalzyerTests
//
//  Created by Michael Charland on 2019-12-21.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import XCTest

class WarningTests: XCTestCase {
    func testToHTML() {
        let warning = TestWarning()
        XCTAssertEqual(warning.toHTML(), "|Symbol|Detailed Description|Measured Value|")
    }
}
