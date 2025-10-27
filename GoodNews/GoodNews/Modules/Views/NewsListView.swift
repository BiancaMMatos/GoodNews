//
//  NewsListView.swift
//  GoodNews
//
//  Created by Bianca Maciel on 23/09/25.
//

import SwiftUI

struct NewsListView: View {
    
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var viewModel: NewsListViewModel
    
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
                ToolbarItem(placement: .navigationBarLeading) {
                    Picker("Category", selection: $viewModel.selectedCategory) {
                        Text("All").tag(String?.none)
                        ForEach(viewModel.categoryViewModels, id: \.title) { categoryVM in
                            Text(categoryVM.title).tag(Optional(categoryVM.title))
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Text("\(viewModel.totalArticlesCount) articles")
                        .font(.caption)
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                }
            }

            .task {
                await loadData()
            }
        }
    }
    
    private var listView: some View {
        List {
            Text(Date(), style: .date)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .cornerRadius(8)
            
            ForEach(viewModel.filteredCategoryViewModels) { categoryVM in
                Section {
                    ForEach(categoryVM.articleViewModels()) { articleVM in
                        NewsCellView(articleVM: articleVM)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                    }
                } header: {
                    HStack {
                        Text(categoryVM.title)
                            .font(.title)
                            .foregroundStyle(Color.white)
                        
                        Spacer()
                        
                        Text("\(categoryVM.articleCount)")
                            .font(.caption)
                            .foregroundStyle(Color.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(theme.secondaryColor.opacity(0.3))
                            .cornerRadius(10)
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(theme.secondaryColor)
                    .cornerRadius(8)
                }
                .textCase(nil)
            }
        }
        .listStyle(.grouped)
    }
    
    private func loadData() async {
        await viewModel.populateHeadlinesAndArticles()
    }
}

#Preview {
    let factory = ViewModelFactory()
    NewsListView(factory: factory)
}
