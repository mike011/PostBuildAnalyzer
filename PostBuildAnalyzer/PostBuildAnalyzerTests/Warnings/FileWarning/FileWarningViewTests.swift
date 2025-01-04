//
//  FileWarningViewTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2019-12-25.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Testing

@Suite struct FileWarningViewTests {
    @Test func symbol() {
        let warning = FileWarningView()
        #expect(warning.symbol == "⚠️")
    }

    @Test func detailedDescripiton() {
        let warning = FileWarningView()
        let model = FileWarningModel(repoURL: "https://github.com/mike011/PostBuildAnalyzer", branch: "", line: "/Users/michael/Documents/git/PostBuildAnalyzer/example/Before/Example/ExistingClassCovered.swift:1:2: warning: 'index(of:)' is deprecated: renamed to 'firstIndex(of:)'")
        let ahref = "<a href=\"https://github.com/mike011/PostBuildAnalyzer/blob//example/Before/Example/ExistingClassCovered.swift#L1\">ExistingClassCovered.swift</a>"
        let expected = "\(ahref) on line 1<br><i>'index(of:)' is deprecated: renamed to 'firstIndex(of:)'</i>"
        #expect(warning.getDetailedDescription(model: model) == expected)
    }

    @Test func detailedDescripitonWithCoreData() {
        let warning = FileWarningView()
        let line = "/Users/distiller/project/application/A/A/Core Data/A.xcdatamodeld/A 6.1.4.xcdatamodel:TMOAccountInfo.premiumState: warning: error"
        let model = FileWarningModel(repoURL: "https://github.com/mike011/PostBuildAnalyzer", branch: "", line: line)
        let file = "application/A/A/Core Data/A.xcdatamodeld/A 6.1.4.xcdatamodel:TMOAccountInfo.premiumState"
        let expected = "\(file)<br><i>error</i>"
        #expect(warning.getDetailedDescription(model: model) == expected)
    }

    @Test func measuredValue() {
        let warning = FileWarningView()
        let model = FileWarningModel(repoURL: "", branch: "", line: "")
        #expect(warning.getMeasuredValue(model: model) == "1 times")
    }
}
