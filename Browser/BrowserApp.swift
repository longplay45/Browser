//
//  BrowserApp.swift
//  Browser
//
//  Created by i on 17.08.23.
//

import SwiftUI
import WebKit

@main
struct BrowserApp: App {
    @State private var isSettingsVisible: Bool = true
    @AppStorage("currentNumber") var currentNumber: String = "1"
    @AppStorage("startupURL") var startupURL: String = "http://localhost:8501"
    @State private var urls: [String] = readURLs() ?? [] // Read URLs using the function provided earlier
    
    var body: some Scene {
        WindowGroup {
            ContentView(currentNumber: currentNumber)
        }
        
        MenuBarExtra(currentNumber, systemImage: "\(currentNumber).circle") {
            // Build buttons dynamically based on URLs
            ForEach(urls.indices, id: \.self) { index in
                Button(urls[index]) {
                    currentNumber = "\(index + 1)"
                }
            }

            Divider()

            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }.keyboardShortcut("q")
        }
    }
}


