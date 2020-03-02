//
//  Warning.swift
//  PostBuildAnalyzer
//
//  Created by Michael Charland on 2019-12-20.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

protocol WarningModel {
    static var lookFor: String { get }
    var line: String { get }
    var description: String { get }
    var count: Double { get set }
    func compareTo(line: String) -> Bool
}

extension WarningModel {
    func compareTo(line: String) -> Bool {
        return self.line == line
    }
}
