//
//  newsApp.swift
//  news
//
//  Created by Giuseppe Maiarù on 19/06/22.
//

import SwiftUI

@main
struct newsApp: App {
    
    let persistanceController = PerisistanceController.shared
    
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            HomeView(vm: Factory.shared.homeViewModel)
        }
        .onChange(of: scenePhase) { newValue in
            switch newValue {
                
            case .background:
                print("scene is in background")
                persistanceController.save()
            case .inactive:
                print("scene is in inactive")
            case .active:
                print("scene is in active")
            @unknown default:
                print("changed somethings")
            }
        }
    }
}
