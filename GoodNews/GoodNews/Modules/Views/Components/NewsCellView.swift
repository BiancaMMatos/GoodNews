//
//  NewsCellView.swift
//  GoodNews
//
//  Created by Bianca Maciel on 23/09/25.
//

import SwiftUI

struct NewsCellView: View {
    let articleVM: ArticleViewModel
    @State private var image: UIImage? = nil
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(articleVM.title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .lineLimit(2)
                    .foregroundColor(.primary)
                
                Text(articleVM.description ?? "")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Group {
                if let url = articleVM.imageURL {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        case .failure:
                            Image(systemName: "mockedImage")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.gray)
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    Image(systemName: "newspaper")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.gray)
                }
            }
            .frame(width: 60, height: 60)
            .clipShape(RoundedRectangle(cornerRadius: 8.0))
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    NewsCellView(articleVM: ArticleViewModel.init(Article.mockedArticles[0]))
}
