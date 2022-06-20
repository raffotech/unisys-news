//
//  WebClient.swift
//  news
//
//  Created by Giuseppe Maiarù on 19/06/22.
//

import Foundation
import Combine



class RemoteDataSource: NewsDataSource {
    let host:String
    let apiKey:String
    
    
    init(host: String, apiKey: String) {
        self.host = host
        self.apiKey = apiKey
    }
    
    
    func fetchNews() async throws -> [ArticleDTO] {
        
        guard let url = NewsApi.allArticles.url(host:host,apiKey: apiKey) else{
            throw APIServiceError.badUrl
        }
        print("->called url:\(url)")
        
        guard let (data, response) = try? await URLSession.shared.data(from: url) else{
            throw APIServiceError.requestError
        }
        
        print("server response \(data.prettyPrintedJSONString ?? "")")
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
            throw APIServiceError.statusNotOK
        }
        
        do {
            let result = try JSONDecoder().decode(GetArticlesDTO.self, from: data)
            return result.articles
        }catch (let error){
            print(String(describing: error))
            throw APIServiceError.decodingError
        }
        
        
    }
    
    func searchNews(searchTerms: String) async throws -> [ArticleDTO] {
        guard let url = NewsApi.search(searchTerms).url(host:host,apiKey: apiKey) else{
            throw APIServiceError.badUrl
        }
        print(url)
        
        guard let (data, response) = try? await URLSession.shared.data(from: url) else{
            throw APIServiceError.requestError
        }
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
            throw APIServiceError.statusNotOK
        }
        
        guard let result = try? JSONDecoder().decode(GetArticlesDTO.self, from: data) else {
            throw APIServiceError.decodingError
        }
        
        return result.articles
    }
    
    
    
}
extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}
