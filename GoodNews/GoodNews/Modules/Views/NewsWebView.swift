//
//  NewsWebView.swift
//
//
//  Created by Bianca Maciel on 12/11/25.
//

import WebKit
import SwiftUI

struct NewsWebView: UIViewControllerRepresentable {
    let url: String?
    @Environment(\.dismiss) var dismiss
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let webView = WKWebView()
        
        /// Configuring webView
        webView.frame = viewController.view.bounds
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.view.addSubview(webView)
        
        /// Configuring navigation bar
        let closeButton = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: context.coordinator,
            action: #selector(Coordinator.closeTapped)
        )
        viewController.navigationItem.rightBarButtonItem = closeButton
        
        /// Loading URL
        if let urlString = url, let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        }
        
        return UINavigationController(rootViewController: viewController)
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(dismiss: dismiss)
    }
    
    class Coordinator {
        let dismiss: DismissAction
        
        init(dismiss: DismissAction) {
            self.dismiss = dismiss
        }
        
        @objc func closeTapped() {
            dismiss()
        }
    }
}
