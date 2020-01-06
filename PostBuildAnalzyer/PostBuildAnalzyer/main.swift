//
//  main.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-04-20.
//  Copyright © 2019 charland. All rights reserved.
//

import Foundation

let before = Utils.loadData(type: Arguments.self, file: CommandLine.arguments[1])
let after = Utils.loadData(type: Arguments.self, file: CommandLine.arguments[2])

if let before = before, let after = after {
    PostBuildComparsion(before: before, after: after).printTable()
} else {
    fatalError()
}
