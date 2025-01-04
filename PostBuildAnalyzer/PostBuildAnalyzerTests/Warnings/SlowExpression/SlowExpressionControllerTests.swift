//
//  SlowExpressionControllerTests.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2019-12-26.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Testing

@Suite struct SlowExpressionControllerTests {
    @Test func equals() {
        let line = "41.38ms\t/Users/michael/Warnings.swift:12:10\tinstance method firstWarning()"
        let sec = SlowExpressionController(repoURL: "", branch: "", line: line)

        let line2 = "31.38ms\t/Users/michael/Warnings.swift:12:10\tinstance method firstWarning()"
        let sec2 = SlowExpressionController(repoURL: "", branch: "", line: line2)

        #expect(sec == sec2)
    }

    @Test func amountOfWarnings() {
        let line = "41.38ms\t/Users/michael/Warnings.swift:12:10\tinstance method firstWarning()"
        let controller = SlowExpressionController(repoURL: "", branch: "", line: line)

        #expect(controller.getTotalWarnings() == 41.38)
        controller.add(amount: 58.62)
        #expect(controller.getTotalWarnings() == 100.00)
    }
}
