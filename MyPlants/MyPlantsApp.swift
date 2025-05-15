//
//  MyPlantsApp.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 08.05.2025.
//

import SwiftUI

@main
struct MyPlantsApp: App {
    @StateObject private var subscriptionManager = SubscriptionManager()
    
    var body: some Scene {
        WindowGroup {
            Group {
                if !subscriptionManager.isInitialized {
                    Color.bg.ignoresSafeArea()
                        .overlay(ProgressView())
                } else {
                    ZStack {
                        if subscriptionManager.isSubscribed {
                            CustomTabView()
                        } else {
                            OnboardingView()
                                .environmentObject(subscriptionManager)
                        }
                    }
                    .animation(.easeInOut(duration: 0.3), value: subscriptionManager.isSubscribed)
                }
            }
        }
    }
}
