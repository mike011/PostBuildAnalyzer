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
        let wa = PostBuildAnalzyer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile)
        XCTAssertTrue(wa.allWarnings.isEmpty)
    }

    func testAWarningKeyboard() {
        var logFile = [String]()
        logFile.append(": warning: ")
        let wa = PostBuildAnalzyer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile)
        XCTAssertFalse(wa.allWarnings.isEmpty)
    }

    func testAWarningFullLine() {
        var logFile = [String]()
        logFile.append("/Users/distiller/project/application/Personal/Personal/Resources/Media.xcassets:./Inhouse Ad/Personal_Avatar-1.imageset: warning: The image set name \"Personal_Avatar-1\" is used by multiple image sets.")
        let wa = PostBuildAnalzyer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile)
        XCTAssertFalse(wa.allWarnings.isEmpty)
        XCTAssertNotNil(try XCTUnwrap(wa.allWarnings[0]))
    }

    func testAWarningMultiline() throws {
        var logFile = [String]()
        logFile.append("/Users/distiller/project/application/Personal/Pods/AFNetworking/AFNetworking/AFHTTPClient.h:89:2: warning: MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
        logFile.append(" #warning MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
        logFile.append(" ^")

        let wa = PostBuildAnalzyer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile)
        XCTAssertFalse(wa.allWarnings.isEmpty)
        let warning = try XCTUnwrap(wa.allWarnings[0])
        XCTAssertNotNil(warning)
        XCTAssertEqual(warning.getTotalWarnings(), 1)
    }

    func testMultipleFileWarningThatAreMultiline() throws {
        var logFile = [String]()
        logFile.append("/Users/distiller/project/application/Personal/Pods/AFNetworking/AFNetworking/AFHTTPClient.h:89:2: warning: MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
        logFile.append(" #warning MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
        logFile.append(" ^")
        logFile.append("/Users/distiller/project/application/Personal/Pods/AFNetworking/AFNetworking/AFHTTPClient.h:89:3: warning: MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
        logFile.append(" #warning MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
        logFile.append(" ^")

        let wa = PostBuildAnalzyer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile)
        XCTAssertFalse(wa.allWarnings.isEmpty)
        XCTAssertEqual(wa.allWarnings.count, 2)
    }

    func testLDWarning() {
        var logFile = [String]()
        logFile.append("ld: warning: directory not found for option '-F/Users/distiller/project/application/Personal/Personal/Features/Ads/SDKs/IASDKVideo'")
        let wa = PostBuildAnalzyer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile)
        XCTAssertFalse(wa.allWarnings.isEmpty)
        XCTAssertEqual(wa.allWarnings.count, 1)
        XCTAssertNotNil(try XCTUnwrap(wa.allWarnings[0]))
    }

    func testMultipleLDWarning() {
        var logFile = [String]()
        logFile.append("ld: warning: directory not found for option '-F/Users/distiller/project/application/Personal/Personal/Features/Ads/SDKs/IASDKVideo'")
        logFile.append("ld: warning: directory not found for option '-F/Users/distiller/project/application/Personal/Personal/Features/Ads/SDKs/IASDKVideo2'")
        let wa = PostBuildAnalzyer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile)
        XCTAssertFalse(wa.allWarnings.isEmpty)
        XCTAssertEqual(wa.allWarnings.count, 2)
    }

    func testMultipleFileWarningThatAreMultilineGetReport() throws {
        var logFile = [String]()
        logFile.append("/Users/distiller/project/application/Personal/Pods/AFNetworking/AFNetworking/AFHTTPClient.h:89:2: warning: MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
        logFile.append(" #warning MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
        logFile.append(" ^")
        logFile.append("/Users/distiller/project/application/Personal/Pods/AFNetworking/AFNetworking/AFHTTPClient.h:89:2: warning: MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
        logFile.append(" #warning MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
        logFile.append(" ^")

        let wa = PostBuildAnalzyer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile)
        XCTAssertEqual(wa.allWarnings.count, 1)
    }

    func testMultipleWarningsRepeated() {
        var logFile = [String]()
        logFile.append(": warning: ")
        logFile.append(": warning: ")
        let wa = PostBuildAnalzyer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile)
        XCTAssertFalse(wa.allWarnings.isEmpty)
    }
}
