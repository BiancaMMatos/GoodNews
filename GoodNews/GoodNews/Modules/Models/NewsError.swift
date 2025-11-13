//
//  NewsError.swift
//  GoodNews
//
//  Created by Bianca Maciel on 25/09/25.
//

import Foundation

struct NewsError: Error {
    let status: String
    let code: String
    let message: String
}

