//
//  WarningAnalyzerTests.swift
//  PostBuildAnalzyerTests
//
//  Created by Michael Charland on 2019-12-20.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import XCTest

class WarningAnalyzerTests: XCTestCase {

    func testNotAWarning() {
        var logFile = [String]()
        logFile.append("Not a warning")
        let wa = WarningAnalyzer(logFile: logFile)
        XCTAssertTrue(wa.warnings.isEmpty)
    }

    func testAWarningKeyboard() {
        var logFile = [String]()
        logFile.append(": warning: ")
        let wa = WarningAnalyzer(logFile: logFile)
        XCTAssertFalse(wa.warnings.isEmpty)
    }

    func testAWarningFullLine() {
        var logFile = [String]()
        logFile.append("/Users/distiller/project/application/Personal/Personal/Resources/Media.xcassets:./Inhouse Ad/Personal_Avatar-1.imageset: warning: The image set name \"Personal_Avatar-1\" is used by multiple image sets.")
        let wa = WarningAnalyzer(logFile: logFile)
        XCTAssertFalse(wa.warnings.isEmpty)
        XCTAssertNotNil(try XCTUnwrap(wa.warnings[0] as? FileWarning))
    }

    func testAWarningMultiline() throws {
        var logFile = [String]()
        logFile.append("/Users/distiller/project/application/Personal/Pods/AFNetworking/AFNetworking/AFHTTPClient.h:89:2: warning: MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
        logFile.append(" #warning MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
        logFile.append(" ^")

        let wa = WarningAnalyzer(logFile: logFile)
        XCTAssertFalse(wa.warnings.isEmpty)
        let warning = try XCTUnwrap(wa.warnings[0] as? FileWarning)
        XCTAssertNotNil(warning)
        XCTAssertFalse(warning.details.isEmpty)
        XCTAssertEqual(warning.details.count, 2)
        XCTAssertEqual(warning.details[0], "#warning MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
        XCTAssertEqual(warning.details[1], "  ^")
    }

    func testLDWarning() {
        var logFile = [String]()
        logFile.append("ld: warning: directory not found for option '-F/Users/distiller/project/application/Personal/Personal/Features/Ads/SDKs/IASDKVideo'")
        let wa = WarningAnalyzer(logFile: logFile)
        XCTAssertFalse(wa.warnings.isEmpty)
        XCTAssertNotNil(try XCTUnwrap(wa.warnings[0] as? LDWarning))
    }
}
