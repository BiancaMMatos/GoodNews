//
//  NewsItem.swift
//  GoodNews
//
//  Created by Bianca Maciel on 23/09/25.
//

import Foundation


struct NewsItem: Identifiable {
    let id = UUID()
    let title: String
    let content: String
    let imageName: String
}


extension NewsItem {
    static let mockedItems: [NewsItem] = [
        NewsItem(title: "News 1", content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", imageName: "example"),
        
        NewsItem(title: "News 2", content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.", imageName: "example"),
        
        NewsItem(title: "News 3", content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.", imageName: "example"),
        
        NewsItem(title: "News 4", content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", imageName: "example")
    ]
}
