//
//  CategoryViewModel.swift
//  GoodNews
//
//  Created by Bianca Maciel on 13/10/25.
//

import Combine
import Foundation

final class CategoryViewModel: Identifiable, ObservableObject {
    let id = UUID()
    var title: String
    private(set) var articles: [Article]
    
    var articleCount: Int { articles.count }
    
    init(title: String, articles: [Article]) {
        self.title = title
        self.articles = articles
    }
    
    
    func articleViewModels() -> [ArticleViewModel] {
        return articles.map { ArticleViewModel($0) }
    }

}
