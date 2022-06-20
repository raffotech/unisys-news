//
//  GetAllArticles.swift
//  news
//
//  Created by Giuseppe Maiarù on 20/06/22.
//

import Foundation

protocol GetAllArticles:UseCase {
    
    func execute()async -> Result<[Article],AppError>
    
}

class DefaultAllArticles: GetAllArticles {
    
    let repo:NewsRepository
    
    init(repo:NewsRepository){
        self.repo = repo
    }
    
    func execute() async -> Result<[Article], AppError> {
        
        do{
            let articles = try await repo.fetchNews()
            return .success(articles.sorted(by: { i0, i1 in
                guard let publishedAt0 = i0.publishedAt, let publishedAt1 = i1.publishedAt else {
                    return false
                }
                return publishedAt0 < publishedAt1}))
            
        }catch(let error){
            switch(error){
            case AppError.decodingError:
                return .failure(.decodingError)
            default:
                return .failure(.networkError)
            }
        }
    }
}
