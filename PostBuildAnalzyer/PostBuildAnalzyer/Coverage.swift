// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let project = try? newJSONDecoder().decode(Project.self, from: jsonData)

import Foundation

// MARK: - Project
public struct Project: Codable {
    let coveredLines: Double
    let lineCoverage: Double
    public let targets: [Target]
    let executableLines: Int
}

// MARK: - Target
public struct Target: Codable {
    let coveredLines: Int
    let lineCoverage: Double
    public let files: [File]
    let name: String
    let executableLines: Int
    let buildProductPath: String
}

// MARK: - File
public struct File: Codable {
    public let coveredLines: Int
    public let lineCoverage: Double
    public let path: String
    let functions: [Function]?
    public let name: String
    let executableLines: Int
}

// MARK: - Function
struct Function: Codable {
    let coveredLines, lineNumber, executionCount: Int
    let lineCoverage: Double
    let name: String
    let executableLines: Int
}
