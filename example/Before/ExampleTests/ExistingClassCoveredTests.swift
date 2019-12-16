//
//  ExistingClassCoveredTests.swift
//  ExampleTests
//
//  Created by Michael Charland on 2019-11-10.
//  Copyright © 2019 charland. All rights reserved.
//

@testable import Example
import XCTest

class ExistingClassCoveredTests: XCTestCase {

    func testExistingClassCoveredTests() {
        ExistingClassCovered().existingFunctionCovered()
    }
}
