//
//  NewsError.swift
//  GoodNews
//
//  Created by Bianca Maciel on 25/09/25.
//

import Foundation

struct NewsError: Error, Identifiable {
    let id = UUID()
    let status: String
    let code: String
    let message: String
}

