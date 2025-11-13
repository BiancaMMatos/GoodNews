//
//  CategoryService.swift
//  GoodNews
//
//  Created by Bianca Maciel on 13/10/25.
//

import Foundation

protocol CategoryServiceProtocol {
    func getAllHeadlines(completion: @escaping (Result<[Category], NewsError>) -> ())
}

final class CategoryService: CategoryServiceProtocol {
    
    let repository: NewsRepositoryProtocol
    
    init(repository: NewsRepositoryProtocol) {
        self.repository = repository
    }
    
    func getAllHeadlines(completion: @escaping (Result<[Category], NewsError>) -> ()) {
        
        var categories = [Category]()
        var requestCount = 0
        let categoriesList = Category.all()
        let categoriesCount = categoriesList.count
        
        categoriesList.forEach { category in
            repository.fetchNews(Article.by(category)) { (result: Result<[Article]?, NewsError>) in
                requestCount += 1
                
                switch result {
                case .success(let articlesOpt):
                    let articles = articlesOpt ?? []
                    let category = Category(title: category, articles: articles)
                    categories.append(category)
                    
                case .failure(let error):
                    let newsError = NewsError(status: error.status, code: error.code, message: error.message)
                    completion(.failure(newsError))
                }
                
                if requestCount == categoriesCount {
                    DispatchQueue.main.async {
                        completion(.success(categories))
                    }
                }
            }
        }
    }
}
