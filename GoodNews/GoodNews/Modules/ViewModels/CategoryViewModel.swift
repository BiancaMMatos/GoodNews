//
//  CategoryViewModel.swift
//  GoodNews
//
//  Created by Bianca Maciel on 13/10/25.
//

import Combine

final class CategoryViewModel: ObservableObject {
    
    let service: CategoryServiceProtocol
    @Published var categories: [Category] = []
    
    init(service: CategoryServiceProtocol) {
        self.service = service
    }
    
    
    func populateHeadlinesAndArticles() {
        service.getAllHeadlines { categories in
            print(categories)
        }
    }
    
}
