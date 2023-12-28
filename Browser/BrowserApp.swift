import SwiftUI
import WebKit

class WebViewManager: ObservableObject {
    @Published var webView: WKWebView?

    func reloadWebView() {
        webView?.reload()
    }
}

class FileUtility {
    static func openTextEditor() {
        guard let fileURL = Bundle.main.url(forResource: "urls", withExtension: "txt") else {
            print("Failed to locate urls.txt in the app bundle.")
            return
        }
        
        let textEditURL = URL(fileURLWithPath: "/System/Applications/TextEdit.app")

        let configuration = NSWorkspace.OpenConfiguration()
        NSWorkspace.shared.open([fileURL], withApplicationAt: textEditURL, configuration: configuration, completionHandler: nil)
    }
}


@main
struct BrowserApp: App {
    @ObservedObject var webViewManager = WebViewManager()
    @State private var isSettingsVisible: Bool = true
    @AppStorage("currentNumber") var currentNumber: String = "1"
    @State private var urls: [String] = readURLs() ?? []

    var body: some Scene {
        WindowGroup {
            ContentView(currentNumber: currentNumber)
        }

        MenuBarExtra(currentNumber, systemImage: "\(currentNumber).circle") {
            ForEach(urls.indices, id: \.self) { index in
                Button(urls[index]) {
                    currentNumber = "\(index + 1)"
                }
            }

            Divider()

            Button("Edit") {
                FileUtility.openTextEditor()
                print("Edit urls")
            }

            Button("Reload") {
                webViewManager.reloadWebView()
                urls = readURLs() ?? []
                print("Trigger Reload via Menu.")
            }

            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
        }
    }
}
