//
//  UtilsTests.swift
//  PostBuildAnalzyerTests
//
//  Created by Michael Charland on 2019-12-01.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import XCTest

class UtilsTests: XCTestCase {

    func testGetParentFileNameWithSlashReturnsFolder() {
        XCTAssertEqual(Utils.getParentURL(file: "a/b.json").absoluteString, URL(fileURLWithPath: "a").absoluteString + "/")
    }

    func testGetParentFileForURL() {
        XCTAssertEqual(Utils.getParentURL(web: "http://www.nba.com/b.json").absoluteString, URL(string:"http://www.nba.com/")?.absoluteURL.absoluteString)
    }
}
