//
//  NewsRepository.swift
//  GoodNews
//
//  Created by Bianca Maciel on 25/09/25.
//

import Foundation

protocol NewsRepositoryProtocol {
    func fetchNews<T: Decodable>(_ resource: Resource<T>, completion: @escaping (Result<T?, NewsError>) -> Void)
}


final class NewsRepository: NewsRepositoryProtocol {
    
    func fetchNews<T: Decodable>(_ resource: Resource<T>, completion: @escaping (Result<T?, NewsError>) -> Void) {
        URLSession.shared.dataTask(with: resource.url) { data, response, error in
            
            if let error = error as? NewsError {
                print("🚨 Error fetching news: \(error.message)")
                
                completion(.failure(error))
            }
            
            if let data {
                DispatchQueue.main.async {
                    completion(.success(resource.parse(data)))
                }
            }
        }
        .resume()
    }
    
}


struct Resource<T> {
    let url: URL
    let parse: (Data) -> T?
}
