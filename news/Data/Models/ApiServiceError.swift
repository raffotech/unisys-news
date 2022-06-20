//
//  ApiServiceError.swift
//  news
//
//  Created by Giuseppe Maiarù on 20/06/22.
//

import Foundation
enum APIServiceError: Error{
    case badUrl, requestError, decodingError, statusNotOK
}
