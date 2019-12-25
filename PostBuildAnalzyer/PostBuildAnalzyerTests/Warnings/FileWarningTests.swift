//
//  FileWarningTests.swift
//  PostBuildAnalzyerTests
//
//  Created by Michael Charland on 2019-12-20.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import XCTest

class FileWarningTests: XCTestCase {
    func testWarning() {
        let description = "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/ExistingClassCovered.swift:15:26: warning: 'index(of:)' is deprecated: renamed to 'firstIndex(of:)'"
        let warning = FileWarning(repoURL: "https://github.com/mike011/PostBuildAnalyzer", branch: "master", firstLine: description)
        XCTAssertEqual(warning.file, "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/ExistingClassCovered.swift")
        XCTAssertEqual(warning.lineNumber, 15)
        XCTAssertEqual(warning.indent, 26)
        XCTAssertEqual(warning.description, "'index(of:)' is deprecated: renamed to 'firstIndex(of:)'")
        XCTAssertTrue(warning.details.isEmpty)
        XCTAssertEqual(warning.count, 1)
    }

    func testWarningSingleDigitNumbers() {
        let description = "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/ExistingClassCovered.swift:1:2: warning: 'index(of:)' is deprecated: renamed to 'firstIndex(of:)'"
        let warning = FileWarning(repoURL: "", branch: "", firstLine: description)
        XCTAssertEqual(warning.lineNumber, 1)
        XCTAssertEqual(warning.indent, 2)
    }

    func testWarningTripleDigitNumbers() {
        let description = "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/ExistingClassCovered.swift:145:267: warning: 'index(of:)' is deprecated: renamed to 'firstIndex(of:)'"
        let warning = FileWarning(repoURL: "", branch: "", firstLine: description)
        XCTAssertEqual(warning.lineNumber, 145)
        XCTAssertEqual(warning.indent, 267)
    }

    func getSampleWarning() -> FileWarning {
        let warning = FileWarning(repoURL: "https://github.com/mike011/PostBuildAnalyzer", branch: "master", firstLine: "Documents/git/PostBuildAnalyzer/example/Before/Example/ExistingClassCovered.swift:15:26: warning: 'index(of:)' is deprecated")
        warning.add(line: "if let index = s.index(of: \"a\") {")
        warning.add(line: "               ^")
        return warning
    }

    func getAnotherSampleWarning() -> FileWarning {
        let warning = FileWarning(repoURL: "", branch: "", firstLine: "Documents/git/PostBuildAnalyzer/example/Before/Example/Frank.swift:16:15: warning: result of call to 'substring(to:)' is unused")
        warning.add(line: "s.substring(to: index)")
        warning.add(line: "  ^        ~~~~~~~~~~~")
        warning.count = 2
        return warning
    }

    func testAddLine() {
        let warning = getSampleWarning()
        XCTAssertEqual(warning.details.count, 1)
        XCTAssertEqual(warning.details[0], "if let index = s.index(of: \"a\") {")
    }

    func testSymbol() {
        let warning = getSampleWarning()
        XCTAssertEqual(warning.symbol, "⚠️")
    }

    func testGetFileName() {
        let warning = getSampleWarning()
        XCTAssertEqual(warning.getFilename(), "ExistingClassCovered.swift")
    }

    func testGetURL() {
        let warning = getSampleWarning()
        XCTAssertEqual(warning.getURL(), "https://github.com/mike011/PostBuildAnalyzer/blob/master/example/Before/Example/ExistingClassCovered.swift#L15")
    }

    func testGetURLCircleFolder() {
        let warning = FileWarning(repoURL: "https://github.com/mike011/PostBuildAnalyzer", branch: "master", firstLine: "/Users/distiller/project/example/Before/Example/ExistingClassCovered.swift:15:26: warning: 'index(of:)' is deprecated")
        XCTAssertEqual(warning.getURL(), "https://github.com/mike011/PostBuildAnalyzer/blob/master/example/Before/Example/ExistingClassCovered.swift#L15")
    }

    func testDetailedDescripiton() {
        let warning = getSampleWarning()
        var col2 = "<a href=\"https://github.com/mike011/PostBuildAnalyzer/blob/master/example/Before/Example/ExistingClassCovered.swift#L15\">ExistingClassCovered.swift</a> on line 15<br>"
        col2 += "<i>'index(of:)' is deprecated</i>"
        XCTAssertEqual(warning.detailedDescripiton, col2)
    }

    func testMesauredValue() {
        let warning = getSampleWarning()
        XCTAssertEqual(warning.measuredValue, "1 times")
    }

    func testMesauredValueWithMultipleValues() {
        let warning = getAnotherSampleWarning()
        XCTAssertEqual(warning.measuredValue, "2 times")
    }

    func testGetRepo() {
        XCTAssertEqual(FileWarning.getRepoName(fromRepoURL: "junk"), "junk")
        XCTAssertEqual(FileWarning.getRepoName(fromRepoURL: "https://github.com/mike011/PostBuildAnalyzer"), "PostBuildAnalyzer")
    }

    func testWarningWithNoLineNumbers() {
        let warning = FileWarning(repoURL: "https://github.com/mike011/PostBuildAnalyzer", branch: "master", firstLine: "/Users/distiller/project/application/Frank/Bob/Core Data/ILDRates.xcdatamodeld/ILDRates 8.15.0.xcdatamodel:TMORate.dialCodes: warning: TMORate.dialCodes does not have an inverse")

        XCTAssertEqual(warning.detailedDescripiton, "/Users/distiller/project/application/Frank/Bob/Core Data/ILDRates.xcdatamodeld/ILDRates 8.15.0.xcdatamodel:TMORate.dialCodes: warning: TMORate.dialCodes does not have an inverse")
    }

    func testEqualsSameObject() {
        let warning = FileWarning(repoURL: "https://github.com/mike011/PostBuildAnalyzer", branch: "master", firstLine: "/Users/distiller/project/application/Frank/Bob/Core Data/ILDRates.xcdatamodeld/ILDRates 8.15.0.xcdatamodel:TMORate.dialCodes: warning: TMORate.dialCodes does not have an inverse")

        let warning2 = FileWarning(repoURL: "https://github.com/mike011/PostBuildAnalyzer", branch: "master", firstLine: "/Users/distiller/project/application/Frank/Bob/Core Data/ILDRates.xcdatamodeld/ILDRates 8.15.0.xcdatamodel:TMORate.dialCodes: warning: TMORate.dialCodes does not have an inverse")

        XCTAssertEqual(warning, warning2)
    }

    func testEquals() {
        let warning = FileWarning(repoURL: "https://github.com/mike011/PostBuildAnalyzer", branch: "master", firstLine: "/Users/distiller/project/application/Frank/Bob/Core Data/ILDRates.xcdatamodeld/ILDRates 8.15.0.xcdatamodel:TMORate.dialCodes: warning: TMORate.dialCodes does not have an inverse")

        let warning2 = FileWarning(repoURL: "https://github.com/mike011/PostBuildAnalyzer", branch: "master", firstLine: "/Users/distiller/project/application/Frank/Core Data/ILDRates.xcdatamodeld/ILDRates 8.15.0.xcdatamodel:TMORate.dialCodes: warning: TMORate.dialCodes does not have an inverse")

        XCTAssertNotEqual(warning, warning2)
    }
}
