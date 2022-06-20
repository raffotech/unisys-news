//
//  NewsFetcher.swift
//  news
//
//  Created by Giuseppe Maiarù on 19/06/22.
//

import Foundation
import Combine

protocol NewsDataSource {
    
    func fetchNews() async throws -> [ArticleDTO]
    func searchNews(searchTerms:String) async throws -> [ArticleDTO]
    
    
}


