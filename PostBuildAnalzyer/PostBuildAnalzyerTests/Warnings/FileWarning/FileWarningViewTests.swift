//
//  FileWarningViewTests.swift
//  PostBuildAnalzyerTests
//
//  Created by Michael Charland on 2019-12-25.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import XCTest

class FileWarningViewTests: XCTestCase {
    func testSymbol() {
        let warning = FileWarningView()
        XCTAssertEqual(warning.symbol, "⚠️")
    }

    func testDetailedDescripitonNotParsable() {
        let warning = FileWarningView()
        let model = FileWarningModel(repoURL: "", branch: "", firstLine: "directory not found for option")
        XCTAssertEqual(warning.getDetailedDescription(model: model), "directory not found for option")
    }

    func testDetailedDescripiton() {
        let warning = FileWarningView()
        let model = FileWarningModel(repoURL: "https://github.com/mike011/PostBuildAnalyzer", branch: "", firstLine: "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/ExistingClassCovered.swift:1:2: warning: 'index(of:)' is deprecated: renamed to 'firstIndex(of:)'")
        let ahref = "<a href=\"https://github.com/mike011/PostBuildAnalyzer/blob//example/Before/Example/ExistingClassCovered.swift#L1\">ExistingClassCovered.swift</a>"
        let expected = "\(ahref) on line 1<br><i>'index(of:)' is deprecated: renamed to 'firstIndex(of:)'</i>"
        XCTAssertEqual(warning.getDetailedDescription(model: model), expected)
    }

    func testMeasuredValue() {
        let warning = FileWarningView()
        let model = FileWarningModel(repoURL: "", branch: "", firstLine: "")
        XCTAssertEqual(warning.getMeasuredValue(model: model), "1 times")
    }
}
