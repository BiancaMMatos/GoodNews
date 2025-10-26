//
//  ArticleViewModel.swift
//  GoodNews
//
//  Created by Bianca Maciel on 25/10/25.
//

import Combine
import Foundation

struct ArticleViewModel: Identifiable {
    let id = UUID()
    private(set) var article: Article
    
    var title: String {
        return self.article.title
    }
    
    var description: String? {
        return self.article.description
    }
    
    var imageURL: URL? {
            guard let urlString = article.imageURL else { return nil }
            return URL(string: urlString)
    }
    
    init(_ article: Article) {
        self.article = article
    }
    
    
}
