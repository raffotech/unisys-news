//
//  DetailView.swift
//  news
//
//  Created by Giuseppe Maiarù on 19/06/22.
//

import Foundation
import SwiftUI


struct DetailView:View {
    
    
    let article:Article
    
    var body: some View {
        ScrollView {
            VStack {
                if let date = article.publishedAt {
                    let dateString:String = "\(date.description)"
                    Text(dateString)
                }
                Text(article.title).multilineTextAlignment(.center).font(.title).padding()
                AsyncImage(
                    url: article.imageUrl,
                    content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            
                    },
                    placeholder: {
                        ProgressView()
                    }
                )
                Text(article.content)
                    .fixedSize(horizontal: false, vertical: true)
                
            }
        }
    }
    
    
}
