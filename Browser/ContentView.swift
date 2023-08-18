//
//  ContentView.swift
//  Browser
//
//  Created by i on 17.08.23.
//

import SwiftUI
import WebKit


struct ContentView: View {
    // This will be bound to the text field where users enter a URL.
    @State private var userInputURL: String = ""

    // This is where we'll store and fetch the startup URL.
    @AppStorage("startupURL") var startupURL: String = "http://localhost:8501"

    var body: some View {
        VStack(spacing: 10) {
            if (false) {
                TextField("Enter startup URL", text: $userInputURL)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("Save URL") {
                    // Save the entered URL to UserDefaults.
                    startupURL = userInputURL
                }
                .padding()
                .buttonStyle(PrimaryButtonStyle())

                Divider()
            }


            WebView(urlString: startupURL)
        }
        .padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    @State static private var isSettingsVisible = true

    static var previews: some View {
        ContentView()
    }
}

struct WebView: NSViewRepresentable {
    let urlString: String
    
    func makeNSView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateNSView(_ nsView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            nsView.load(request)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }

        // Implement any WKNavigationDelegate methods if needed
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8.0)
    }
}


struct ToggleSettingsCommand: Commands {
    @Binding var isSettingsVisible: Bool

    var body: some Commands {
        CommandGroup(after: CommandGroupPlacement.newItem) {
            Button(action: {
                withAnimation {
                    isSettingsVisible.toggle()
                }
            }) {
                Text("Toggle Settings")
            }
            .keyboardShortcut("s", modifiers: [.command])
        }
    }
}

