//
//  LintWarningModelTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2020-02-05.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import Foundation
import Testing

@Suite struct LintWarningModelTests {
    @Test func symbol() {
        let warning = LintWarningView()
        #expect(warning.symbol == "🧽")
    }

    @Test func parsing() {
        let model = LintWarningModel(
            repoURL: "https://github.com/mike011/PostBuildAnalyzer",
            branch: "Before",
            line: "<td>Collection literals should not have trailing commas.</td>",
            file: "<td>Example/SlowFiles.swift</td>",
            location: "<td style=\"text-align: center;\">32:46</td>"
        )
        #expect(model.file == "Example/SlowFiles.swift")
        #expect(model.lineNumber == 32)
        #expect(model.url == URL(string: "https://github.com/mike011/PostBuildAnalyzer/blob/Before/Example/SlowFiles.swift#L32"))
    }

    @Test func detailedDescripiton() {
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
        #expect(warning.getDetailedDescription(model: model) == expected)
    }

    @Test func measuredValue() {
        let warning = LintWarningView()
        let model = LintWarningModel(repoURL: "url", branch: "branch", line: "", file: "file", location: "3:3")
        #expect(warning.getMeasuredValue(model: model) == "1 times")
    }
}
