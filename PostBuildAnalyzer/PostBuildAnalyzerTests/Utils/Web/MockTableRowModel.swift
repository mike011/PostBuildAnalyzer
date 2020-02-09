//
//  MockTableRowModel.swift
//  PostBuildAnalyzerTests
//
//  Created by Michael Charland on 2020-01-10.
//  Copyright © 2020 Michael Charland. All rights reserved.
//

import Foundation

class MockTableRowModel: TableRowModel {
    var columns: [String]

    init(columns: [String]) {
        self.columns = columns
    }
}
