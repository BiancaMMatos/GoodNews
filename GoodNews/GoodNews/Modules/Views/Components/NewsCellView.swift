//
//  NewsCellView.swift
//  GoodNews
//
//  Created by Bianca Maciel on 23/09/25.
//

import SwiftUI

struct NewsCellView: View {
    
    let news: Article
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(news.title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .lineLimit(2)
                    .foregroundColor(.primary)
                
                Text(news.description ?? "no description")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(news.imageURL ?? "example")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    NewsCellView(news: Article.mockedArticles[3])
}
