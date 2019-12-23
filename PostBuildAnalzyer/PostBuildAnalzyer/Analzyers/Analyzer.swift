//
//  Analyzer.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-12-23.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

import Foundation

protocol Analyzer {
    var warnings: [Warning] { get }
}
