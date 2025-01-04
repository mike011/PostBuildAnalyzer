//
//  UtilsTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2019-12-01.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation
import Testing

@Suite struct UtilsTests {
    @Test func getParentFileNameWithSlashReturnsFolder() {
        #expect(Utils.getParentURL(file: "a/b.json").absoluteString == URL(fileURLWithPath: "a").absoluteString + "/")
    }

    @Test func getParentFileForURL() {
        #expect(Utils.getParentURL(web: "http://www.nba.com/b.json").absoluteString == URL(string: "http://www.nba.com/")?.absoluteURL.absoluteString)
    }

    @Test func trimSpaces() {
        #expect(" ".trimSpaces() == "")
        #expect("a ".trimSpaces() == "a")
        #expect(" a".trimSpaces() == "a")
        #expect(" a ".trimSpaces() == "a")
        #expect("       a                     ".trimSpaces() == "a")
    }

    @Test func splits() {
        #expect(Utils.getSplits(description: "") == [String]())
        #expect(Utils.getSplits(description: " ") == [String]())
        #expect(Utils.getSplits(description: "   ") == [String]())
        #expect(Utils.getSplits(description: "a") == ["a"])
        #expect(Utils.getSplits(description: " a ") == ["a"])
        #expect(Utils.getSplits(description: " a\tb") == ["a", "b"])
    }

    @Test func loadData() {
        #expect(Utils.loadData(type: Arguments.self, file: nil) == nil)
        #expect(Utils.loadData(type: Arguments.self, file: "File does not exist") == nil)
        #expect(Utils.loadData(type: Arguments.self, file: EXAMPLE_JSON) != nil)
    }

    @Test func load() {
        #expect(Utils.load(file: nil).isEmpty)
        #expect(!Utils.load(file: EXAMPLE_JSON).isEmpty)
    }

    @Test func writeToFile() {
        let url = URL(fileURLWithPath: "temp.txt", relativeTo: FileManager.default.temporaryDirectory)
        Utils.writeToFile(contents: ["a", "b"], url: url)
        let contents = Utils.load(file: url.path)
        #expect(!contents.isEmpty)
    }
}
