//
//  NewsListViewModel.swift
//  GoodNews
//
//  Created by Bianca Maciel on 23/09/25.
//

import Combine
import Foundation

final class NewsListViewModel: ObservableObject {
    @Published private(set) var categoryViewModels: [CategoryViewModel] = []
    @Published var isLoading = false
    @Published var error: String?
    @Published var selectedCategory: String? = nil
    
    private let categoryService: CategoryServiceProtocol
    
    var totalArticlesCount: Int {
        categoryViewModels.reduce(0) { $0 + $1.articleCount }
    }
    
    var availableCategories: [String] {
        categoryViewModels.map { $0.title }
    }
    
    var filteredCategoryViewModels: [CategoryViewModel] {
        if let selectedCategory = selectedCategory {
            return categoryViewModels.filter { $0.title == selectedCategory }
        } else {
            return categoryViewModels
        }
    }
    
    
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
                    self?.categoryViewModels = categories.map { category in
                        CategoryViewModel(title: category.title, articles: category.articles)
                    }
                    self?.isLoading = false
                    continuation.resume()
                }
            }
        }
    }
    
}
