//
//  Article.swift
//  news
//
//  Created by Giuseppe Maiarù on 20/06/22.
//

import Foundation

class Article: Identifiable {
    
    var author:String
    var title:String
    var description:String
    var url:URL?
    var imageUrl:URL?
    var publishedAt:Date?
    var content:String
    
     init(author: String?,
          title: String?,
          description: String?,
          url: URL?,
          imageUrl: URL?,
          publishedAt: Date?,
          content: String?
     ) {
         self.author = author ?? ""
        self.title = title ?? ""
        self.description = description ?? "No-description"
        self.url = url
        self.imageUrl = imageUrl
         
        self.publishedAt = publishedAt
        self.content = content ?? "Empty Content"
    }
    
    
    
    
   
    
}
