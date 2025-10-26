//
//  NewsListViewModel.swift
//  GoodNews
//
//  Created by Bianca Maciel on 23/09/25.
//

import Combine
import Foundation

final class NewsListViewModel: ObservableObject {
    @Published private(set) var categories: [Category] = []
    @Published var isLoading = false
    @Published var error: String?
    
    private let categoryService: CategoryServiceProtocol
    
    init(categoryService: CategoryServiceProtocol) {
        self.categoryService = categoryService
    }
    
    @MainActor
    func populateHeadlinesAndArticles() async {
        isLoading = true
        error = nil
        
        await withCheckedContinuation { continuation in
            categoryService.getAllHeadlines { [weak self] categories in
                DispatchQueue.main.async {
                    self?.categories = categories
                    self?.isLoading = false
                    continuation.resume()
                }
            }
        }
    }
    
    var sectionTitles: [String] {
        categories.map { $0.title }
    }
    
    func articlesForSection(_ section: Int) -> [ArticleViewModel] {
        guard section < categories.count else { return [] }
        return categories[section].articles.map { ArticleViewModel($0) }
    }
    
    func articleViewModelForIndex(section: Int, index: Int) -> ArticleViewModel? {
        guard section < categories.count,
              index < categories[section].articles.count else {
            return nil
        }
        return ArticleViewModel(categories[section].articles[index])
    }
    
    func categoryTitle(for section: Int) -> String {
        guard section < categories.count else { return "" }
        return categories[section].title
    }
    
    var allArticles: [ArticleViewModel] {
        categories.flatMap { $0.articles.map { ArticleViewModel($0) } }
    }
}
