//
//  NewsListView.swift
//  GoodNews
//
//  Created by Bianca Maciel on 23/09/25.
//

import SwiftUI

struct NewsListView: View {
    
    @Environment(\.theme) private var theme
    
    var body: some View {
        NavigationStack {
            List(NewsItem.mockedItems) { newsItem in
                NewsCellView(news: newsItem)
            }
            .listStyle(.plain)
            .background(Gradient(colors: [theme.primaryColor, .white]))
            .toolbar {
                ToolbarItem {
                    Text("NEWS")
                        .foregroundColor(theme.textColor) // ⭐️ Cor customizada
                        .font(.largeTitle.weight(.bold))
                }
            }
            
        }
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
    
}

#Preview {
    NewsListView()
}
