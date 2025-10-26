//
//  NewsListView.swift
//  GoodNews
//
//  Created by Bianca Maciel on 23/09/25.
//

import SwiftUI

struct NewsListView: View {
    @StateObject private var viewModel: NewsListViewModel
    @Environment(\.theme) private var theme
    
    init(factory: ViewModelFactoryProtocol) {
        _viewModel = StateObject(wrappedValue: factory.makeNewsListViewModel())
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.isLoading {
                    ProgressView("Loading news...")
                        .scaleEffect(1.5)
                } else {
                    newsListView
                }
            }
            .navigationTitle("NEWS")
            .task {
                await loadData()
            }
        }
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
    
    private var newsListView: some View {
        List {
            ForEach(Array(viewModel.categories.enumerated()), id: \.element.title) { sectionIndex, category in
                Section(
                    header: Text(viewModel.categoryTitle(for: sectionIndex))
                        .font(.headline)
                        .foregroundColor(theme.textColor)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(theme.primaryColor)
                        .cornerRadius(8)
                        .textCase(nil)
                ) {
                    ForEach(viewModel.articlesForSection(sectionIndex)) { articleVM in
                        NewsCellView(articleVM: articleVM)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                    }
                }
            }
        }
        .listStyle(.grouped)
        .background(Gradient(colors: [theme.primaryColor.opacity(0.1), .clear]))
    }
    
    private func loadData() async {
        await viewModel.populateHeadlinesAndArticles()
    }
}

#Preview {
    let factory = ViewModelFactory()
    NewsListView(factory: factory)
}
