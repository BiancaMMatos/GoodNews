//
//  ThemeManager.swift
//  GoodNews
//
//  Created by Bianca Maciel on 23/09/25.
//

import SwiftUI
import Combine

@MainActor
class ThemeManager: ObservableObject {
    @Published var primaryColor = Color(red: 47/255, green: 54/255, blue: 64/255)
    @Published var textColor = Color.white
}
