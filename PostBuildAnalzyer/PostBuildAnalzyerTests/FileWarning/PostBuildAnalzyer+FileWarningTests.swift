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
        let wa = PostBuildAnalzyer(repoURL: "", branch: "", minimumTimeInMS: 0, logFile: logFile, lintFile: [String]())
        XCTAssertTrue(wa.warnings.isEmpty)
    }

    func testAWarningKeyboard() {
        var logFile = [String]()
        logFile.append(": warning: ")
        let wa = PostBuildAnalzyer(repoURL: "", branch: "", minimumTimeInMS: 0, logFile: logFile, lintFile: [String]())
        XCTAssertFalse(wa.warnings.isEmpty)
    }

    func testAWarningFullLine() {
        var logFile = [String]()
        logFile.append("/Users/distiller/project/application/Personal/Personal/Resources/Media.xcassets:./Inhouse Ad/Personal_Avatar-1.imageset: warning: The image set name \"Personal_Avatar-1\" is used by multiple image sets.")
        let wa = PostBuildAnalzyer(repoURL: "", branch: "", minimumTimeInMS: 0, logFile: logFile, lintFile: [String]())
        XCTAssertFalse(wa.warnings.isEmpty)
        XCTAssertNotNil(try XCTUnwrap(wa.warnings.popFirst()))
    }

    func testAWarningMultiline() throws {
        var logFile = [String]()
        logFile.append("/Users/distiller/project/application/Personal/Pods/AFNetworking/AFNetworking/AFHTTPClient.h:89:2: warning: MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
        logFile.append(" #warning MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
        logFile.append(" ^")

        let wa = PostBuildAnalzyer(repoURL: "", branch: "", minimumTimeInMS: 0, logFile: logFile, lintFile: [String]())
        XCTAssertFalse(wa.warnings.isEmpty)
        let warning = try XCTUnwrap(wa.warnings[logFile[0]])
        XCTAssertNotNil(warning)
        XCTAssertEqual(warning.getTotalWarnings(), 1)
//        /XCTAssertEqual(warning., "#warning MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
    }

    func testMultipleFileWarningThatAreMultiline() throws {
        var logFile = [String]()
        logFile.append("/Users/distiller/project/application/Personal/Pods/AFNetworking/AFNetworking/AFHTTPClient.h:89:2: warning: MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
        logFile.append(" #warning MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
        logFile.append(" ^")
        logFile.append("/Users/distiller/project/application/Personal/Pods/AFNetworking/AFNetworking/AFHTTPClient.h:89:3: warning: MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
        logFile.append(" #warning MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
        logFile.append(" ^")

        let wa = PostBuildAnalzyer(repoURL: "", branch: "", minimumTimeInMS: 0, logFile: logFile, lintFile: [String]())
        XCTAssertFalse(wa.warnings.isEmpty)
        XCTAssertEqual(wa.warnings.count, 2)
        let warning = try XCTUnwrap(wa.warnings.values)
//        XCTAssertNotNil(warning)
//        XCTAssertEqual(warning.getTotalWarnings(), 1)
//        let warning2 = try XCTUnwrap(wa.warnings.popFirst())
//        XCTAssertNotNil(warning2)
//        XCTAssertEqual(warning2.getTotalWarnings(), 1)
    }

    func testLDWarning() {
        var logFile = [String]()
        logFile.append("ld: warning: directory not found for option '-F/Users/distiller/project/application/Personal/Personal/Features/Ads/SDKs/IASDKVideo'")
        let wa = PostBuildAnalzyer(repoURL: "", branch: "", minimumTimeInMS: 0, logFile: logFile, lintFile: [String]())
        XCTAssertFalse(wa.warnings.isEmpty)
        XCTAssertEqual(wa.warnings.count, 1)
        XCTAssertNotNil(try XCTUnwrap(wa.warnings.popFirst()))
    }

    func testMultipleLDWarning() {
        var logFile = [String]()
        logFile.append("ld: warning: directory not found for option '-F/Users/distiller/project/application/Personal/Personal/Features/Ads/SDKs/IASDKVideo'")
        logFile.append("ld: warning: directory not found for option '-F/Users/distiller/project/application/Personal/Personal/Features/Ads/SDKs/IASDKVideo2'")
        let wa = PostBuildAnalzyer(repoURL: "", branch: "", minimumTimeInMS: 0, logFile: logFile, lintFile: [String]())
//        XCTAssertFalse(wa.warnings.isEmpty)
//        XCTAssertEqual(wa.warnings.getTotalWarnings(), 2)
//        XCTAssertNotNil(try XCTUnwrap(wa.warnings.popFirst()))
//        XCTAssertNotNil(try XCTUnwrap(wa.warnings.popFirst()))
    }

    func testMultipleFileWarningThatAreMultilineGetReport() throws {
        var logFile = [String]()
        logFile.append("/Users/distiller/project/application/Personal/Pods/AFNetworking/AFNetworking/AFHTTPClient.h:89:2: warning: MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
        logFile.append(" #warning MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
        logFile.append(" ^")
        logFile.append("/Users/distiller/project/application/Personal/Pods/AFNetworking/AFNetworking/AFHTTPClient.h:89:2: warning: MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
        logFile.append(" #warning MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
        logFile.append(" ^")

        let wa = PostBuildAnalzyer(repoURL: "", branch: "", minimumTimeInMS: 0, logFile: logFile, lintFile: [String]())
        XCTAssertEqual(wa.warnings.count, 1)
//        XCTAssertEqual(wa.warnings.popFirst()?.getTotalWarnings(), 2)
    }

    func testMultipleWarningsRepeated() {
        var logFile = [String]()
        logFile.append(": warning: ")
        logFile.append(": warning: ")
        let wa = PostBuildAnalzyer(repoURL: "", branch: "", minimumTimeInMS: 0, logFile: logFile, lintFile: [String]())
        XCTAssertFalse(wa.warnings.isEmpty)
//        XCTAssertEqual(wa.warnings.popFirst()?.getTotalWarnings(), 2)
    }
}
