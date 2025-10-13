//
//  Article.swift
//  GoodNews
//
//  Created by Bianca Maciel on 13/10/25.
//

import Foundation

struct NewsSourcesResponse: Decodable {
    let articles: [Article]
}

struct Article: Identifiable, Decodable {
    var id = UUID()
    let title: String
    let description: String?
    let url: String?
    let imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case url
        case imageURL = "urlToImage"
    }
}

extension Article {
    
    static func by(_ category: String) -> Resource<[Article]> {
        return Resource<[Article]>(url: URL.urlForTopHeadlines(for: category)) { data in
            return try! JSONDecoder().decode(NewsSourcesResponse.self, from: data).articles
        }
    }
    
}

extension Article {
    static let mockedArticles: [Article] = [
        Article(title: "News 1", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", url: nil, imageURL: "example"),
        
        Article(title: "News 2", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.", url: nil, imageURL: "example"),
        
        Article(title: "News 3", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.", url: nil, imageURL: "example"),
        
        Article(title: "News 4", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", url: nil, imageURL: "example")
    ]
}
