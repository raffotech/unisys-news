//
//  StorageClient.swift
//  news
//
//  Created by Giuseppe Maiarù on 20/06/22.
//

import Foundation

class LocalDataSource:LocalPersistanceDataSource {
    
    func saveInCache(articles: [ArticleDTO]) {
        for item in articles {
            PerisistanceController.shared.saveArticle(item)
        }
    }
    
    private var news:[ArticleDTO] = []
    
    func fetchNews() async throws -> [ArticleDTO] {
        do {
           let article = try await PerisistanceController.shared.fetchArticles()
            self.news = article
            return article
        }catch{
            throw AppError.networkError
        }
         
    }
    
    func searchNews(searchTerms: String) async throws -> [ArticleDTO] {
        return news.filter { item in
            let matchTitle = item.title?.contains(searchTerms) ?? false
//            let matchContent = item.content?.contains(searchTerms) ?? false
            return matchTitle 
        }
    }
    
    
    
    
}
