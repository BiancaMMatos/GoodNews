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
                    listView
                }
            }
            .navigationTitle("NEWS")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Text("\(viewModel.totalArticlesCount) articles")
                        .font(.caption)
                        .foregroundColor(theme.textColor)
                }
            }
            .task {
                await loadData()
            }
        }
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
    
    private var listView: some View {
        List {
            ForEach(viewModel.categoryViewModels) { categoryVM in
                Section {
                    Text(Date(), style: .date)
                    ForEach(categoryVM.articleViewModels()) { articleVM in
                        NewsCellView(articleVM: articleVM)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                    }
                } header: {
                    HStack {
                        Text(categoryVM.title)
                            .font(.headline)
                            .foregroundColor(theme.textColor)
                        
                        Spacer()
                        
                        Text("\(categoryVM.articleCount)")
                            .font(.caption)
                            .foregroundColor(theme.textColor.opacity(0.8))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(theme.primaryColor.opacity(0.3))
                            .cornerRadius(10)
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(theme.primaryColor)
                    .cornerRadius(8)
                }
                .textCase(nil)
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
