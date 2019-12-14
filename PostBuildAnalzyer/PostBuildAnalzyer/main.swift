//
//  main.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-04-20.
//  Copyright © 2019 charland. All rights reserved.
//

import Foundation

let arguments = CommandLine.arguments

if arguments.count != 2 && arguments.count != 3 {
    print("Missing arguments, expected the following: ")
    print("\t1 - Build log output file")
    print("\t2 - Output folder location")
    print("\t3 - (Optional) SwiftLint html file location")
    fatalError()
}

let logFileName = arguments[1]
let outputPath = arguments[2]
let lintFileName = arguments[3]

func go() {
    let pba = PostBuildAnalzyer(logFile: logFileName, lintFile: lintFileName)
    pba.createReports()
    pba.write()
}
go()

