//
//  main.swift
//  PostBuildAnalzyer
//
//  Created by Michael Charland on 2019-04-20.
//  Copyright © 2019 charland. All rights reserved.
//

import Foundation

let arguments = CommandLine.arguments

if arguments.count < 5 || arguments.count > 7 {
    print("Missing arguments \(arguments.count) found, expected the following: ")
    print("\t1 - Repo name")
    print("\t2 - Develop Build log report file")
    print("\t3 - PR Build log output file")
    print("\t4 - Output folder location")
    print("\t5 - (Optional) Develop SwiftLint html file location")
    print("\t6 - (Optional) PR SwiftLint html file location")
    fatalError()
}

func go(arguments: [String]) {
    let repoName = arguments[1]
    let developLogReportFileName = arguments[2]
    let prLogFileName = arguments[3]
    let outputPath = arguments[4]
    var prLintFileName: String?
    var developLintFileName: String?
    if arguments.count > 6 {
        prLintFileName = arguments[5]
        developLintFileName = arguments[6]
    }

    let logFile = Utils.load(file: prLogFileName)
    let lintFile = Utils.load(file: prLintFileName)
    let pba = PostBuildAnalzyer(repoName: repoName, logFile: logFile, lintFile: lintFile)
    pba.createReports()
    pba.write(toLocation: outputPath)
}

go(arguments: arguments)
