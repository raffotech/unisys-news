//
//  LocalPersistanceDataSource.swift
//  news
//
//  Created by Giuseppe Maiarù on 21/06/22.
//

import Foundation
protocol LocalPersistanceDataSource :NewsDataSource {
    func saveInCache(articles:[ArticleDTO])
}
