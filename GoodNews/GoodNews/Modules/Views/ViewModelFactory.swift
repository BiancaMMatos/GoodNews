//
//  ViewModelFactory.swift
//  GoodNews
//
//  Created by Bianca Maciel on 13/10/25.
//


protocol ViewModelFactoryProtocol {
    func makeCategoryViewModel() -> CategoryViewModel
    func makeNewsViewModel() -> NewsViewModel
}


final class ViewModelFactory: ViewModelFactoryProtocol {
    
    private let newsRepository: NewsRepositoryProtocol
    private let categoryService: CategoryServiceProtocol
    
    init(newsRepository: NewsRepositoryProtocol = NewsRepository(), categoryService: CategoryServiceProtocol? = nil) {
        self.newsRepository = newsRepository
        self.categoryService = categoryService ?? CategoryService(repository: newsRepository)
    }
    
    func makeCategoryViewModel() -> CategoryViewModel {
        return CategoryViewModel(service: categoryService)
    }
    
    func makeNewsViewModel() -> NewsViewModel {
        return NewsViewModel()
    }
    
    
}
