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
    
    var body: some Scene {
        WindowGroup {
            NewsListView()
                .environment(\.theme, theme)
                .accentColor(theme.textColor)
        }
    }
}
