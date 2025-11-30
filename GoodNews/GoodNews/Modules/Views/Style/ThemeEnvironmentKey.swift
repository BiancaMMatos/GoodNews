//
//  ThemeEnvironmentKey.swift
//  GoodNews
//
//  Created by Bianca Maciel on 26/10/25.
//

import SwiftUI

struct ThemeKey: EnvironmentKey {
    static let defaultValue: ThemeManager = ThemeManager()
}

extension EnvironmentValues {
    var theme: ThemeManager {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
}
