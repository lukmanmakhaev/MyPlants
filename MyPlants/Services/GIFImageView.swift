//
//  GIFImageView.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 14.05.2025.
//

import SwiftUI
import WebKit


struct GIFImageView: UIViewRepresentable {
    private let name: String
    init(_ name: String) {
        self.name = name
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webview = WKWebView()
        webview.isOpaque = false
        webview.backgroundColor = .clear
        webview.scrollView.backgroundColor = .clear

        if let url = Bundle.main.url(forResource: name, withExtension: "gif"),
           let data = try? Data(contentsOf: url) {
            webview.load(data,
                         mimeType: "image/gif",
                         characterEncodingName: "UTF-8",
                         baseURL: url.deletingLastPathComponent())
        }
        
        return webview
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
    }
}


enum URLType {
  case name(String)
  case url(URL)

  var url: URL? {
    switch self {
      case .name(let name):
        return Bundle.main.url(forResource: name, withExtension: "gif")
      case .url(let remoteURL):
        return remoteURL
    }
  }
}
