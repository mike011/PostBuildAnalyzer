//
//  main.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-04-20.
//  Copyright © 2019 charland. All rights reserved.
//

import Foundation

let arguments = CommandLine.arguments

if arguments.count != 4, arguments.count != 5 {
    print("Missing arguments \(arguments.count) found, expected the following: ")
    print("\t1 - Repo name")
    print("\t2 - Build log output file")
    print("\t3 - Output folder location")
    print("\t4 - (Optional) SwiftLint html file location")
    fatalError()
}

func go(arguments: [String]) {
    let repoName = arguments[1]
    let logFileName = arguments[2]
    let outputPath = arguments[3]
    var lintFileName: String?
    if arguments.count > 4 {
        lintFileName = arguments[4]
    }

    let logFile = Utils.load(file: logFileName)
    let lintFile = Utils.load(file: lintFileName)
    let pba = PostBuildAnalzyer(repoName: repoName, logFile: logFile, lintFile: lintFile)
    pba.createReports()
    pba.write(toLocation: outputPath)
}

go(arguments: arguments)
