//
//  WarningAnalyzerTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2019-12-20.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Testing

@Suite struct WarningAnalyzerTests {
    @Test func notAWarning() {
        var logFile = [String]()
        logFile.append("Not a warning")
        let wa = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: [])
        #expect(wa.allWarnings.isEmpty)
    }

    @Test func aWarningKeyboard() {
        var logFile = [String]()
        logFile.append(": warning: ")
        let wa = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: [])
        #expect(!wa.allWarnings.isEmpty)
    }

    @Test func aWarningFullLine() {
        var logFile = [String]()
        logFile.append("/Users/distiller/project/application/Personal/Personal/Resources/Media.xcassets:./Inhouse Ad/Personal_Avatar-1.imageset: warning: The image set name \"Personal_Avatar-1\" is used by multiple image sets.")
        let wa = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: [])
        #expect(!wa.allWarnings.isEmpty)
        #expect(wa.allWarnings[0] != nil)
    }

    @Test func aWarningMultiline() throws {
        var logFile = [String]()
        logFile.append("/Users/distiller/project/application/Personal/Pods/AFNetworking/AFNetworking/AFHTTPClient.h:89:2: warning: MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
        logFile.append(" #warning MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
        logFile.append(" ^")

        let wa = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: [])
        #expect(!wa.allWarnings.isEmpty)
        let warning = wa.allWarnings[0]
        #expect(warning != nil)
        #expect(warning.getTotalWarnings() == 1)
    }

    @Test func multipleFileWarningThatAreMultiline() throws {
        var logFile = [String]()
        logFile.append("/Users/distiller/project/application/Personal/Pods/AFNetworking/AFNetworking/AFHTTPClient.h:89:2: warning: MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
        logFile.append(" #warning MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
        logFile.append(" ^")
        logFile.append("/Users/distiller/project/application/Personal/Pods/AFNetworking/AFNetworking/AFHTTPClient.h:89:3: warning: MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
        logFile.append(" #warning MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
        logFile.append(" ^")

        let wa = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: [])
        #expect(!wa.allWarnings.isEmpty)
        #expect(wa.allWarnings.count == 2)
    }

    @Test func linkerWarning() {
        var logFile = [String]()
        logFile.append("ld: warning: directory not found for option '-F/Users/distiller/project/application/Personal/Personal/Features/Ads/SDKs/IASDKVideo'")
        let wa = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: [])
        #expect(!wa.allWarnings.isEmpty)
        #expect(wa.allWarnings.count == 1)
        #expect(wa.allWarnings[0] != nil)
    }

    @Test func multipleLinkerWarning() {
        var logFile = [String]()
        logFile.append("ld: warning: directory not found for option '-F/Users/distiller/project/application/Personal/Personal/Features/Ads/SDKs/IASDKVideo'")
        logFile.append("ld: warning: directory not found for option '-F/Users/distiller/project/application/Personal/Personal/Features/Ads/SDKs/IASDKVideo2'")
        let wa = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: [])
        #expect(!wa.allWarnings.isEmpty)
        #expect(wa.allWarnings.count == 2)
    }

    @Test func multipleFileWarningThatAreMultilineGetReport() throws {
        var logFile = [String]()
        logFile.append("/Users/distiller/project/application/Personal/Pods/AFNetworking/AFNetworking/AFHTTPClient.h:89:2: warning: MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
        logFile.append(" #warning MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
        logFile.append(" ^")
        logFile.append("/Users/distiller/project/application/Personal/Pods/AFNetworking/AFNetworking/AFHTTPClient.h:89:2: warning: MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
        logFile.append(" #warning MobileCoreServices framework not found in project, or not included in precompiled header. Automatic MIME type detection when uploading files in multipart requests will not be available.")
        logFile.append(" ^")

        let wa = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: [])
        #expect(wa.allWarnings.count == 1)
    }

    @Test func multipleWarningsRepeated() {
        var logFile = [String]()
        logFile.append(": warning: ")
        logFile.append(": warning: ")
        let wa = PostBuildAnalyzer(repoURL: "", branch: "", buildTimeThresholdInMS: 0, logFile: logFile, lintFile: [String](), ignorePaths: [])
        #expect(!wa.allWarnings.isEmpty)
    }
}
