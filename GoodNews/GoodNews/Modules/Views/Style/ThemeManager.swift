//
//  ThemeManager.swift
//  GoodNews
//
//  Created by Bianca Maciel on 26/10/25.
//

import SwiftUI
import Combine

@MainActor
class ThemeManager: ObservableObject {
    @Published var primaryColor = Color(red: 0/255, green: 2/255, blue: 51/255, opacity: 20.0)
    @Published var secondaryColor = Color(red: 107/255, green: 12/255, blue: 12/255, opacity: 77.0)
    @Published var textColor = Color.secondary
}
