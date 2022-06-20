//
//  News.swift
//  news
//
//  Created by Giuseppe Maiarù on 19/06/22.
//

import Foundation

struct ArticleDTO : Codable {
    
    
    var author:String?
    var title:String?
    var description:String?
    var url:String?
    var urlToImage:String?
    var publishedAt:String?
    var content:String?
    
    
    init(entity:ArticleEntity){
//        self.publishedAt = DateFormatter.
        
        self.urlToImage = entity.urlToImage

        self.content = entity.content
        
        self.url = entity.url
        
        self.title = entity.title
        self.author = entity.author


    }
    
}

