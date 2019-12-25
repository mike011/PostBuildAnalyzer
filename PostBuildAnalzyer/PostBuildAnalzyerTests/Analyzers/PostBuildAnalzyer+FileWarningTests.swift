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
        XCTAssertTrue(wa.fileWarnings.isEmpty)
    }

    func testAWarningKeyboard() {
        var logFile = [String]()
        logFile.append(": warning: ")
        let wa = PostBuildAnalzyer(repoURL: "", branch: "", minimumTimeInMS: 0, logFile: logFile, lintFile: [String]())
        XCTAssertFalse(wa.fileWarnings.isEmpty)
    }

    func testAWarningFullLine() {
        var logFile = [String]()
        logFile.append("/Users/distiller/project/application/Personal/Personal/Resources/Media.xcassets:./Inhouse Ad/Personal_Avatar-1.imageset: warning: The image set name \"Personal_Avatar-1\" is used by multiple image sets.")
        let wa = PostBuildAnalzyer(repoURL: "", branch: "", minimumTimeInMS: 0, logFile: logFile, lintFile: [String]())
        XCTAssertFalse(wa.fileWarnings.isEmpty)
        XCTAssertNotNil(try XCTUnwrap(wa.fileWarnings.popFirst()))
    }

    func testAWarningMultiline() throws {
        var logFile = [String]()
        logFile.append("/Users/distiller/project/application/Personal/Pods/AFNetworking/AFNetworking/AFHTTPClient.h:89:2: warning: MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
        logFile.append(" #warning MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
        logFile.append(" ^")

        let wa = PostBuildAnalzyer(repoURL: "", branch: "", minimumTimeInMS: 0, logFile: logFile, lintFile: [String]())
        XCTAssertFalse(wa.fileWarnings.isEmpty)
        let warning = try XCTUnwrap(wa.fileWarnings.popFirst())
        XCTAssertNotNil(warning)
        XCTAssertFalse(warning.details.isEmpty)
        XCTAssertEqual(warning.details.count, 1)
        XCTAssertEqual(warning.details[0], "#warning MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
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
        XCTAssertFalse(wa.fileWarnings.isEmpty)
        XCTAssertEqual(wa.fileWarnings.count, 2)
        let warning = try XCTUnwrap(wa.fileWarnings.popFirst())
        XCTAssertNotNil(warning)
        XCTAssertEqual(warning.details.count, 1)
        let warning2 = try XCTUnwrap(wa.fileWarnings.popFirst())
        XCTAssertNotNil(warning2)
        XCTAssertEqual(warning2.details.count, 1)
    }

    func testLDWarning() {
        var logFile = [String]()
        logFile.append("ld: warning: directory not found for option '-F/Users/distiller/project/application/Personal/Personal/Features/Ads/SDKs/IASDKVideo'")
        let wa = PostBuildAnalzyer(repoURL: "", branch: "", minimumTimeInMS: 0, logFile: logFile, lintFile: [String]())
        XCTAssertFalse(wa.lDWarnings.isEmpty)
        XCTAssertEqual(wa.lDWarnings.count, 1)
        XCTAssertNotNil(try XCTUnwrap(wa.lDWarnings.popFirst()))
    }

    func testMultipleLDWarning() {
        var logFile = [String]()
        logFile.append("ld: warning: directory not found for option '-F/Users/distiller/project/application/Personal/Personal/Features/Ads/SDKs/IASDKVideo'")
        logFile.append("ld: warning: directory not found for option '-F/Users/distiller/project/application/Personal/Personal/Features/Ads/SDKs/IASDKVideo2'")
        let wa = PostBuildAnalzyer(repoURL: "", branch: "", minimumTimeInMS: 0, logFile: logFile, lintFile: [String]())
        XCTAssertFalse(wa.lDWarnings.isEmpty)
        XCTAssertEqual(wa.lDWarnings.count, 2)
        XCTAssertNotNil(try XCTUnwrap(wa.lDWarnings.popFirst()))
        XCTAssertNotNil(try XCTUnwrap(wa.lDWarnings.popFirst()))
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
        XCTAssertEqual(wa.fileWarnings.count, 1)
        XCTAssertEqual(wa.fileWarnings.popFirst()?.count, 2)
    }

    func testMultipleWarningsRepeated() {
        var logFile = [String]()
        logFile.append(": warning: ")
        logFile.append(": warning: ")
        let wa = PostBuildAnalzyer(repoURL: "", branch: "", minimumTimeInMS: 0, logFile: logFile, lintFile: [String]())
        XCTAssertFalse(wa.fileWarnings.isEmpty)
        XCTAssertEqual(wa.fileWarnings.popFirst()?.count, 2)
    }

    func testContainsNotFound() {
        let wa = PostBuildAnalzyer(repoURL: "", branch: "", minimumTimeInMS: 0, logFile: [String](), lintFile: [String]())

        let w = FileWarning(repoURL: "", branch: "", firstLine: "A")

        var ws = Set<FileWarning>()
        ws.insert(FileWarning(repoURL: "", branch: "", firstLine: "X"))
        ws.insert(FileWarning(repoURL: "", branch: "", firstLine: "Y"))

        XCTAssertNil(wa.get(warning: w, in: ws))
    }

    func testContainsFound() {
        let wa = PostBuildAnalzyer(repoURL: "", branch: "", minimumTimeInMS: 0, logFile: [String](), lintFile: [String]())

        let w = FileWarning(repoURL: "", branch: "", firstLine: "X")

        var ws = Set<FileWarning>()
        ws.insert(FileWarning(repoURL: "", branch: "", firstLine: "X"))
        ws.insert(FileWarning(repoURL: "", branch: "", firstLine: "T"))

        XCTAssertNotNil(wa.get(warning: w, in: ws))
    }
}
