//
//  MockTotalRowView.swift
//  PostBuildAnalzyerTests
//
//  Created by Michael Charland on 2020-01-01.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import Foundation

class MockTotalRowView: TotalRowView {
    var symbol = "S"
    var description = "D"
    var before = [WarningController]()
    var after = [WarningController]()
}
