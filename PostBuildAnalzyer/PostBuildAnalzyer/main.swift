//
//  main.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-04-20.
//  Copyright © 2019 charland. All rights reserved.
//

import Foundation

if let pbc = PostBuildComparsion(arguments: CommandLine.arguments) {
    pbc.printTable()
} else {
    fatalError()
}
