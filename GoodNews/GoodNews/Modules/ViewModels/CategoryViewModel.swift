//
//  CategoryViewModel.swift
//  GoodNews
//
//  Created by Bianca Maciel on 13/10/25.
//

import Combine


final class CategoryViewModel: ObservableObject {
    
    let service = CategoryService()
    
    func populateHeadlinesAndArticles() {
        service.getAllHeadlines { categories in
            print(categories)
        }
    }
    
}
