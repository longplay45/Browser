//
//  URLUtils.swift
//  Browser
//
//  Created by i on 22.08.23.
//

import Foundation

public func readURLs() -> [String]? {
    if let fileURL = Bundle.main.url(forResource: "urls", withExtension: "txt") {
        do {
            let content = try String(contentsOf: fileURL, encoding: .utf8)
            let lines = content.components(separatedBy: .newlines)
            let validURLs = lines.compactMap { (line: String) -> String? in
                let trimmedLine = line.trimmingCharacters(in: .whitespaces)
                if !trimmedLine.isEmpty &&
                   !trimmedLine.hasPrefix("#") &&
                   URL(string: trimmedLine) != nil {
                    return trimmedLine
                }
                return nil
            }
            return Array(validURLs.prefix(9))
        } catch {
            print("Error reading URLs:", error)
            return nil
        }
    }
    return nil
}
