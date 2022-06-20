//
//  GetNewsViewModel.swift
//  news
//
//  Created by Giuseppe Maiarù on 19/06/22.
//

import Foundation
import Combine
import SwiftUI


class HomeViewModel: ObservableObject {
    
    private let getAllArticlesUseCase:GetAllArticles
    private let searchArticlesUseCase:SearchArticles
    
    
    @Published var news: [Article] = []
    
    
    @Published var error: Error? = nil
    @Published var isLoading: Bool = true
    @Published var errorMessage = ""
    @Published var hasError = false
    @Published var searchQuery = ""
    
    @StateObject var connectionMonitor = MonitorReachability()
   
    
    private var searchCancellable:AnyCancellable? = nil

    
    func fetchNews() async {
        let result = await getAllArticlesUseCase.execute()
        DispatchQueue.main.async {
            self.news.removeAll()
            self.errorMessage = ""
            self.isLoading = false
            switch result {
            case .success(let news):
                self.news = news
            case .failure(let error):
                self.news = []
                self.errorMessage = error.localizedDescription
                self.hasError = true
            }
            
        }
    }
    
    func searchNews(searchTerms: String) async{
        
        let result = await searchArticlesUseCase.execute(query: searchTerms)
        DispatchQueue.main.async {
            self.isLoading = false
            switch result {
            case .success(let news):
                self.news.removeAll()
                self.news = news
            case .failure(let error):
                self.news = []
                self.errorMessage = error.localizedDescription
                self.hasError = true
            }
            
        }
    }
    
    init(getAllArticlesUseCase:GetAllArticles,searchArticlesUseCase:SearchArticles){
        self.getAllArticlesUseCase = getAllArticlesUseCase
        self.searchArticlesUseCase = searchArticlesUseCase
        searchCancellable = $searchQuery
            .debounce(for: 0.6, scheduler: RunLoop.main)
            .sink(receiveValue: { (str) in
                if str == ""  {
                    Task{
                        await self.fetchNews()
                    }
                }else {
                    let formattedString = str.replacingOccurrences(of: " ", with: "_")
                    Task{
                     await self.searchNews(searchTerms: formattedString)
                    }
                }
            })
        
    }
    
}
