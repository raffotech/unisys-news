//
//  Routing.swift
//  news
//
//  Created by Giuseppe Maiarù on 19/06/22.
//

import Foundation
import SwiftUI

enum Route {
  
  case detail(Article)
}

protocol Routing {
  associatedtype Route
  associatedtype View: SwiftUI.View
 
  @ViewBuilder func view(for route: Route) -> Self.View
}

struct Navigator {
    
    static func navigate<T: View>(_ route:Route,content:()->T) -> AnyView {
        switch route {
            
        case .detail(let detail):
            return AnyView(NavigationLink(destination:
                                            DetailView(article: detail)
                                         ){
                content()
            })
        }
    }
}


