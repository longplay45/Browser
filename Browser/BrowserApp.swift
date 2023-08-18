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

    var body: some Scene {
        WindowGroup {
            //ContentView(isSettingsVisible: .constant(true))
            ContentView()
        }
        .commands {
            ToggleSettingsCommand(isSettingsVisible: $isSettingsVisible)
        }
    }
}

