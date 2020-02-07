//
//  LintWarningModelTests.swift
//  PostBuildAnalzyerTests
//
//  Created by Michael Charland on 2020-02-05.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import XCTest

class LintWarningModelTests: XCTestCase {
    func testSymbol() {
        let warning = LintWarningView()
        XCTAssertEqual(warning.symbol, "🧽")
    }

    func testParsing() {
        let model = LintWarningModel(
            repoURL: "https://github.com/mike011/PostBuildAnalyzer",
            branch: "Before",
            line: "<td>Collection literals should not have trailing commas.</td>",
            file: "<td>Example/SlowFiles.swift</td>",
            location: "<td style=\"text-align: center;\">32:46</td>"
        )
        XCTAssertEqual(model.file, "Example/SlowFiles.swift")
        XCTAssertEqual(model.lineNumber, 32)
        XCTAssertEqual(model.url, URL(string: "https://github.com/mike011/PostBuildAnalyzer/blob/Before/Example/SlowFiles.swift#L32"))
    }

    func testDetailedDescripiton() {
        let warning = LintWarningView()
        let model = LintWarningModel(
            repoURL: "https://github.com/mike011/PostBuildAnalyzer",
            branch: "branch",
            line: "<td>Collection literals should not have trailing commas.</td>",
            file: "<td>Example/SlowFiles.swift</td>",
            location: "<td style=\"text-align: center;\">32:46</td>"
        )
        let ahref = "<a href=\"https://github.com/mike011/PostBuildAnalyzer/blob/branch/Example/SlowFiles.swift#L32\">SlowFiles.swift</a>"
        let expected = "\(ahref) on line 32<br><i>Collection literals should not have trailing commas.</i>"
        XCTAssertEqual(warning.getDetailedDescription(model: model), expected)
    }

    func testMeasuredValue() {
        let warning = LintWarningView()
        let model = LintWarningModel(repoURL: "url", branch: "branch", line: "", file: "file", location: "3:3")
        XCTAssertEqual(warning.getMeasuredValue(model: model), "1 times")
    }
}
