//
//  NewsGridView.swift
//  GoodNews
//
//  Created by Bianca Maciel on 23/09/25.
//

import SwiftUI

struct NewsGridView: View {
    
    @StateObject private var viewModel = NewsViewModel()
    
    private let columns = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 6.0) {
                    ForEach(NewsItem.mockedItems) { newsItem in
                        NewsCellView(news: newsItem)
                            .background(Color(.systemBackground))
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
                    }
                }
            }
        }
    }
}

#Preview {
    NewsGridView()
}
