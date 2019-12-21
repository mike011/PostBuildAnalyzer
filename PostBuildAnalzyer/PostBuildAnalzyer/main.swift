//
//  main.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-04-20.
//  Copyright © 2019 charland. All rights reserved.
//

import Foundation

let arguments = CommandLine.arguments

if arguments.count != 3 && arguments.count != 4 {
    print("Missing arguments \(arguments.count) found, expected the following: ")
    print("\t1 - Build log output file")
    print("\t2 - Output folder location")
    print("\t3 - (Optional) SwiftLint html file location")
    fatalError()
}

func go(arguments: [String]) {
    let logFileName = arguments[1]
    let outputPath = arguments[2]
    var lintFileName: String?
    if arguments.count > 3 {
        lintFileName = arguments[3]
    }

    let logFile = Utils.load(file: logFileName)
    let lintFile = Utils.load(file: lintFileName)
    let pba = PostBuildAnalzyer(logFile: logFile, lintFile: lintFile)
    pba.createReports()
    pba.write(toLocation: outputPath)
}
go(arguments: arguments)

