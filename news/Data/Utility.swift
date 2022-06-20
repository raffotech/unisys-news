//
//  Utility.swift
//  news
//
//  Created by Giuseppe Maiarù on 20/06/22.
//

import Foundation

extension String {
    
    var date:Date?{
        
        let isoDate = self
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateFormat = dateFormatter.date(from:isoDate)
        return dateFormat
        
    }
}
