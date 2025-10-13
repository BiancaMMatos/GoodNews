//
//  NewsRepository.swift
//  GoodNews
//
//  Created by Bianca Maciel on 25/09/25.
//

import Foundation

protocol NewsRepositoryProtocol {
    func fetchNews<T: Decodable>(_ resource: Resource<T>, completion: @escaping (T?) -> ())
}


final class NewsRepository: NewsRepositoryProtocol {
    
    func fetchNews<T: Decodable>(_ resource: Resource<T>, completion: @escaping (T?) -> ()) {
        URLSession.shared.dataTask(with: resource.url) { data, response, error in
            
            if let error {
                print("Error fetching news: \(error.localizedDescription)")
                completion(nil)
            }
            
            if let data {
                DispatchQueue.main.async {
                    completion(resource.parse(data))
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
