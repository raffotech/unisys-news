//
//  Factory.swift
//  news
//
//  Created by Giuseppe Maiarù on 20/06/22.
//

import Foundation

class Factory {
    
    static let shared = Factory()
    
    let remoteDataSource : NewsDataSource = RemoteDataSource(host: "https://newsapi.org/v2", apiKey: "15d66b3bec7848ccb89d69fd4cee72e1")
    let localDataSource :LocalPersistanceDataSource = LocalDataSource()
    
    let newsRepo :NewsRepository
        
    
    let getAllArticlesUseCase : GetAllArticles
    let searchArticlesUseCase: SearchArticles
    
    let homeViewModel : HomeViewModel
    
    init(){
        self.newsRepo = NewsRepositoryImpl(remote: remoteDataSource, local: localDataSource)
        self.getAllArticlesUseCase = DefaultAllArticles(repo: newsRepo)
        self.searchArticlesUseCase = DefaultSearchArticles(repo: newsRepo)
        self.homeViewModel = HomeViewModel(getAllArticlesUseCase: getAllArticlesUseCase, searchArticlesUseCase: searchArticlesUseCase)
    }
    
}
