//
//  LintWarningViewTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2020-02-06.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import Foundation
import Testing

@Suite struct LintWarningViewTests {
    @Test func symbol() {
        let warning = LintWarningView()
        #expect(warning.symbol == "🧽")
    }

    @Test func detailedDescripiton() {
        let warning = LintWarningView()
        let model = LintWarningModel(
            repoURL: "https://github.com/mike011/PostBuildAnalyzer",
            branch: "branch",
            line: "<td>'index(of:)' is deprecated: renamed to 'firstIndex(of:)'</td>",
            file: "<td>file.swift</td>",
            location: "<td style=\"text-align: center;\">1:46</td>"
        )
        let ahref = "<a href=\"https://github.com/mike011/PostBuildAnalyzer/blob/branch/file.swift#L1\">file.swift</a>"
        let expected = "\(ahref) on line 1<br><i>'index(of:)' is deprecated: renamed to 'firstIndex(of:)'</i>"
        #expect(warning.getDetailedDescription(model: model) == expected)
    }

    @Test func measuredValue() {
        let warning = LintWarningView()
        let model = LintWarningModel(repoURL: "", branch: "", line: "", file: "", location: "")
        #expect(warning.getMeasuredValue(model: model) == "1 times")
    }
}
