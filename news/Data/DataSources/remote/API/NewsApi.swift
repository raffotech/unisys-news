//
//  NewsApi.swift
//  news
//
//  Created by Giuseppe Maiarù on 20/06/22.
//

import Foundation

enum NewsApi {
    
    
    case allArticles,search(String)
    

    
    
    
    func url(host:String,apiKey:String)->URL?{
        switch self {
        case .search(let queryString):
            return URL(string: "\(host)/everything?q=\(queryString)&apiKey=\(apiKey)")
        case .allArticles:
            let countryCode:String = "us"
            return URL(string: "\(host)/top-headlines?country=\(countryCode)&apiKey=\(apiKey)")
        }
    }
    
}


