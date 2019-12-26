//
//  WarningViewTests.swift
//  PostBuildAnalzyerTests
//
//  Created by Michael Charland on 2019-12-25.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import XCTest

class WarningViewTests: XCTestCase {
    func testPrintRow() {
        let view = TestWarningView()
        XCTAssertEqual(view.printRow(model: TestWarningModel()), "|S|detailed descripton|measured value|")
    }
}
