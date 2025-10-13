//
//  NewsListView.swift
//  GoodNews
//
//  Created by Bianca Maciel on 23/09/25.
//

import SwiftUI

struct NewsListView: View {
    @Environment(\.theme) private var theme
    @ObservedObject private var viewModel: CategoryViewModel

    init(viewModel: CategoryViewModel) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            List(viewModel.categories.flatMap { $0.articles }) { newsItem in
                NewsCellView(news: newsItem)
            }
            .listStyle(.plain)
            .background(Gradient(colors: [theme.primaryColor, .white]))
            .navigationTitle("NEWS")
            .toolbar {
                ToolbarItem {
                    Text("NEWS")
                        .foregroundColor(theme.textColor)
                        .font(.largeTitle.weight(.bold))
                }
            }
        }
        .toolbarColorScheme(.dark, for: .navigationBar)
        .onAppear {
            viewModel.populateHeadlinesAndArticles()
        }
    }
}

#Preview {
    let factory = ViewModelFactory()
    NewsListView(viewModel: factory.makeCategoryViewModel())
}
