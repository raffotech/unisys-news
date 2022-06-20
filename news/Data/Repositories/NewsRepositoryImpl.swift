//
//  NewsRepositoryImpl.swift
//  news
//
//  Created by Giuseppe Maiarù on 20/06/22.
//

import Foundation

class NewsRepositoryImpl: NewsRepository {
    
    private let remoteDataSource:NewsDataSource
    private let localDataSource:LocalPersistanceDataSource
    
    private var dataSource:NewsDataSource{
        if Reachability.isConnectedToNetwork() {
            return remoteDataSource
        }else{
            return localDataSource
        }
    }
    
    init(remote:NewsDataSource,local:LocalPersistanceDataSource){
        self.remoteDataSource = remote
        self.localDataSource = local
    }
    
    func fetchNews() async throws -> [Article] {
        do {
            let articlesDTO = try await dataSource.fetchNews()
            let articles:[Article] = articlesDTO.map { dto in
                let parsedDate = dto.publishedAt?.date
                
                return Article(
                    author: dto.author, title: dto.title, description: dto.description, url: dto.url != nil ? URL(string: dto.url!) : nil, imageUrl: dto.urlToImage != nil ? URL(string: dto.urlToImage!) : nil, publishedAt: parsedDate, content: dto.content)
            }
            
            if dataSource is RemoteDataSource {
                self.localDataSource.saveInCache(articles: articlesDTO)
            }
            
            return articles
        }catch(let error){
            switch(error){
            case APIServiceError.decodingError:
                throw AppError.decodingError
            default:
                throw AppError.networkError
            }
        }
        
        
        
    }
    
    func searchNews(searchTerms: String) async throws -> [Article] {
        do {
            let articlesDTO = try await dataSource.searchNews(searchTerms: searchTerms)
            let articles:[Article] = articlesDTO.map { dto in
                let parsedDate = dto.publishedAt?.date
                return Article(
                    author: dto.author, title: dto.title, description: dto.description, url: dto.url != nil ? URL(string: dto.url!) : nil, imageUrl: dto.urlToImage != nil ? URL(string: dto.urlToImage!) : nil, publishedAt: parsedDate, content: dto.content)
            }
            return articles
        }catch(let error){
            switch(error){
            case APIServiceError.decodingError:
                throw AppError.decodingError
            default:
                throw AppError.networkError
            }
        }
        
    }
}
