//
//  NewsRepositories.swift
//  news
//
//  Created by Giuseppe Maiarù on 20/06/22.
//

import Foundation


protocol NewsRepository {
    
    func fetchNews() async throws -> [Article]
    func searchNews(searchTerms:String) async throws -> [Article]
    
    
}
