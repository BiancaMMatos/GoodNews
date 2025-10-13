//
//  Category.swift
//  GoodNews
//
//  Created by Bianca Maciel on 13/10/25.
//

import Foundation


struct Category {
    
    let title: String
    let articles: [Article]
    
    
    static func all() -> [String] {
        return ["Business", "Entertainment", "General", "Sports"]
    }
}



