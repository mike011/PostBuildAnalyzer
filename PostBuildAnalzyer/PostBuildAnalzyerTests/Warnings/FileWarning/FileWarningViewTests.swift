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

    func testDetailedDescripiton() {
        let warning = FileWarningView()
        let model = FileWarningModel(repoURL: "https://github.com/mike011/PostBuildAnalyzer", branch: "", line: "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/ExistingClassCovered.swift:1:2: warning: 'index(of:)' is deprecated: renamed to 'firstIndex(of:)'")
        let ahref = "<a href=\"https://github.com/mike011/PostBuildAnalyzer/blob//example/Before/Example/ExistingClassCovered.swift#L1\">ExistingClassCovered.swift</a>"
        let expected = "\(ahref) on line 1<br><i>'index(of:)' is deprecated: renamed to 'firstIndex(of:)'</i>"
        XCTAssertEqual(warning.getDetailedDescription(model: model), expected)
    }

    func testDetailedDescripitonWithCoreData() {
        let warning = FileWarningView()
        let line = "/Users/distiller/project/application/A/A/Core Data/A.xcdatamodeld/A 6.1.4.xcdatamodel:TMOAccountInfo.premiumState: warning: error"
        let model = FileWarningModel(repoURL: "https://github.com/mike011/PostBuildAnalyzer", branch: "", line: line)
        let file = "application/A/A/Core Data/A.xcdatamodeld/A 6.1.4.xcdatamodel:TMOAccountInfo.premiumState"
        let expected = "\(file)<br><i>error</i>"
        XCTAssertEqual(warning.getDetailedDescription(model: model), expected)
    }

    func testMeasuredValue() {
        let warning = FileWarningView()
        let model = FileWarningModel(repoURL: "", branch: "", line: "")
        XCTAssertEqual(warning.getMeasuredValue(model: model), "1 times")
    }
}
