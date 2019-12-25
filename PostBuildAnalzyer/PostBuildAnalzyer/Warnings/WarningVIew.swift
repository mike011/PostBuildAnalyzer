//
//  WarningVIew.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-25.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

class WarningView {
    private let data: WarningModel

    init(data: WarningModel) {
        self.data = data
    }

    func printRow() {
        print(data.toHTML())
    }
}
