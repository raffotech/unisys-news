//
//  EverythingResponsePayload.swift
//  news
//
//  Created by Giuseppe Maiarù on 19/06/22.
//

import Foundation

struct GetArticlesDTO:Codable {
    let status:String?
    let totalResults:Int?
    let articles:[ArticleDTO]
}
