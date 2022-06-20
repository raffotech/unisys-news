//
//  SearchArticles.swift
//  news
//
//  Created by Giuseppe Maiarù on 20/06/22.
//

import Foundation

protocol SearchArticles:UseCase {
    
    func execute(query:String)async -> Result<[Article],AppError>
    
}

class DefaultSearchArticles : SearchArticles {
    
    var repo:NewsRepository
    func execute(query:String)async -> Result<[Article],AppError>{
        do{
            let articles = try await repo.searchNews(searchTerms:  query)
            return .success(articles.sorted(by: { i0, i1 in
                guard let publishedAt0 = i0.publishedAt, let publishedAt1 = i1.publishedAt else {
                    return false
                }
                return publishedAt0 < publishedAt1
            }))
        }catch(let error){
            switch(error){
            case AppError.decodingError:
                return .failure(.decodingError)
            default:
                return .failure(.networkError)
            }
        }
    }
    
    init(repo:NewsRepository){
        self.repo = repo
    }
    
}
