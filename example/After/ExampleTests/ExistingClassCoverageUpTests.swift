//
//  ExistingClassCoverageUpTests.swift
//  ExampleTests
//
//  Created by Michael Charland on 2019-11-15.
//  Copyright © 2019 charland. All rights reserved.
//

import Foundation

@testable import Example
import XCTest

class ExistingClassCoverageUpTests: XCTestCase {
    func testFunctionOne() {
        ExistingClassCoverageUp().functionOne()
    }

    func testFunctionTwo() {
        ExistingClassCoverageUp().functionTwo()
    }
}
