//
//  NewsListViewModel.swift
//  GoodNews
//
//  Created by Bianca Maciel on 23/09/25.
//

import SwiftUI
import Combine
import Foundation

final class NewsListViewModel: ObservableObject {
    @Published private(set) var categoryViewModels: [CategoryViewModel] = []
    @Published var isLoading = false
    @Published var newsError: NewsError?
    @Published var showAlertError: Bool = false
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
        showAlertError = false
        
        await withCheckedContinuation { continuation in
            categoryService.getAllHeadlines { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let categories):
                        self?.categoryViewModels = categories.map({ category in
                            CategoryViewModel(title: category.title, articles: category.articles)
                        })
                        
                        self?.isLoading = false
                        continuation.resume()
                        
                    case .failure(let newsError):
                        self?.isLoading = false
                        self?.newsError = newsError
                        self?.showAlertError = true
                        continuation.resume()
                    }
                }
            }
        }
    }
    
}

