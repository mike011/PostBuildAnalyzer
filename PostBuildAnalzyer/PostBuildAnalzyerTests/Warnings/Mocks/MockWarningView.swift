//
//  MockWarningView.swift
//  PostBuildAnalzyerTests
//
//  Created by Michael Charland on 2019-12-25.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class MockWarningView: WarningView {
    var columns = [String]()

    var symbol = "S"

    func getDetailedDescription(model: WarningModel) -> String {
        return "detailed descripton"
    }

    func getMeasuredValue(model: WarningModel) -> String {
        return "measured value"
    }
}
