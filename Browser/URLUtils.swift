//
//  URLUtils.swift
//  Browser
//
//  Created by i on 22.08.23.
//

import Foundation

func readURLs() -> [String]? {
    if let fileURL = Bundle.main.url(forResource: "urls", withExtension: "txt") {
        do {
            let content = try String(contentsOf: fileURL, encoding: .utf8)
            return content.components(separatedBy: .newlines).filter { !$0.isEmpty }
        } catch {
            print("Error reading URLs:", error)
            return nil
        }
    }
    return nil
}
