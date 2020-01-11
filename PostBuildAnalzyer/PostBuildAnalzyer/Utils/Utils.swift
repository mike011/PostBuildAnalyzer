//
//  Utils.swift
//  CodeCoverageFramework
//
//  Created by Michael Charland on 2019-11-12.
//  Copyright © 2019 charland. All rights reserved.
//

import Foundation

public class Utils {
    public static func getParentURL(file: String) -> URL {
        let url = URL(fileURLWithPath: file)
        return url.deletingLastPathComponent()
    }

    public static func getParentURL(web: String) -> URL {
        guard let url = URL(string: web) else {
            return URL(fileURLWithPath: web)
        }
        return url.deletingLastPathComponent()
    }

    public static func load(file: String?) -> [String] {
        guard let file = file else {
            return [String]()
        }

        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: file), !fileManager.isReadableFile(atPath: file) {
            print("File not found: \(file)")
            return [String]()
        }

        let data = fileManager.contents(atPath: file)
        let datastring = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        let string = datastring! as String
        return string.components(separatedBy: "\n")
    }

    public static func loadData<T: Decodable>(type: T.Type, file: String?) -> T? {
        guard let file = file else {
            return nil
        }

        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: file) {
            print("File not found: \(file)")
            return nil
        }

        if let data = fileManager.contents(atPath: file) {
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch let DecodingError.keyNotFound(key, context) {
                fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' not found – \(context.debugDescription)")
            } catch let DecodingError.typeMismatch(_, context) {
                fatalError("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
            } catch let DecodingError.valueNotFound(type, context) {
                fatalError("Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
            } catch DecodingError.dataCorrupted(_) {
                fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON")
            } catch {
                fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
            }
        }
        return nil
    }

    static func getSplits(description: String) -> [String] {
        var result = [String]()
        for value in description.components(separatedBy: "\t") {
            let trimmed = value.trimSpaces()
            if !trimmed.isEmpty {
                result.append(trimmed)
            }
        }
        return result
    }

    static func writeToFile(contents: [String], url: URL) {
        do {
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(atPath: url.path)
            }

            if let data = contents[0].data(using: String.Encoding.utf8) {
                try data.write(to: url)
            }
            let fileHandle = try FileHandle(forWritingTo: url)
            for content in contents.dropFirst() {
                fileHandle.seekToEndOfFile()
                let line = content + "\r\n"
                if let data = line.data(using: String.Encoding.utf8) {
                    fileHandle.write(data)
                }
            }
            fileHandle.closeFile()
        } catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
    }
}

extension NSRegularExpression {
    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}

extension String {
    func trimSpaces() -> String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
