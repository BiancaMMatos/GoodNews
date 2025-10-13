//
//  URL+Extensions.swift
//  GoodNews
//
//  Created by Bianca Maciel on 13/10/25.
//

import Foundation


extension URL {
    
    static func urlForTopHeadlines(for category: String) -> URL {
        return URL(string: "https://newsapi.org/v2/top-headlines?category=\(category)&country=us&apiKey=3cafb71d8b0f4f54bbecee0a928d8ec7")!
    }
    
}
