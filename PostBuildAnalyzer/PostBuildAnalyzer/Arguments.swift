//
//  Arguments.swift
//  PostBuildAnalyzer
//
//  Created by Michael Charland on 2019-12-29.
//  Copyright © 2019 Michael Charland. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let arguments = try? newJSONDecoder().decode(Arguments.self, from: jsonData)

import Foundation

// MARK: - Arguments

struct Arguments: Decodable {
    let repoURL: String
    let branch: String
    let outputFolder: String
    let logFileName: String?
    let baseURLPath: String?
    let lintFileName: String?
    let buildTimeThresholdInMS: Double?
}
