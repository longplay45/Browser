//
//  ContentView.swift
//  Browser
//
//  Created by i on 17.08.23.
//

import SwiftUI
import WebKit


struct ContentView: View {
    @State private var userInputURL: String = ""
    @State private var viewSettings = true
    @AppStorage("currentNumber") var currentNumber: String = "1"
    @AppStorage("startupURL") var startupURL: String = "http://localhost:8501"
    @State private var urls: [String] = readURLs() ?? []
    
    var body: some View {
        VStack(spacing: 5) {
            if let currentNumberInt = Int(currentNumber), currentNumberInt > 0, currentNumberInt <= urls.count {
                WebView(urlString: urls[currentNumberInt - 1])
            } else {
                Text("Invalid URL number")
            }
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


