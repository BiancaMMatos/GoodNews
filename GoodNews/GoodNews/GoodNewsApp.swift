//
//  GoodNewsApp.swift
//  GoodNews
//
//  Created by Bianca Maciel on 18/09/25.
//

import SwiftUI

@main
struct GoodNewsApp: App {
    @StateObject private var theme = ThemeManager()
    private let factory: ViewModelFactoryProtocol
    
    init() {
        self.factory = ViewModelFactory()
    }
    
    var body: some Scene {
        WindowGroup {
            NewsListView(factory: factory)
                .environment(\.theme, theme)
                .accentColor(theme.textColor)
        }
    }
}
