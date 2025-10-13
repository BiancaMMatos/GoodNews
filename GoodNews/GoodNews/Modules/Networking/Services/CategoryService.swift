//
//  CategoryService.swift
//  GoodNews
//
//  Created by Bianca Maciel on 13/10/25.
//

import Foundation

protocol CategoryServiceProtocol {
    func getAllHeadlines(completion: @escaping ([Category]) -> ())
}


final class CategoryService: CategoryServiceProtocol {
    
    let repository: NewsRepositoryProtocol
    
    init(repository: NewsRepositoryProtocol = NewsRepository()) {
        self.repository = repository
    }
    
    func getAllHeadlines(completion: @escaping ([Category]) -> ()) {
        
        var categories = [Category]()
        var requestCount = 0
        let categoriesCount = Category.all().count
        
        Category.all().forEach { category in
            repository.fetchNews(Article.by(category)) { articles in
                
                requestCount += 1
                
                guard let articles = articles else { return }
                
                let category = Category(title: category, articles: articles)
                categories.append(category)
                
                if requestCount == categoriesCount {
                    DispatchQueue.main.async {
                        completion(categories)
                    }
                }
            }
        }
    }
}
