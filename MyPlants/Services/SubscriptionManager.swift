//
//  SubscriptionManager.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 15.05.2025.
//

import Foundation
import StoreKit

@MainActor
class SubscriptionManager: ObservableObject {

    @Published var isSubscribed: Bool = false
    @Published var isLoading: Bool = false
    @Published var isInitialized: Bool = false

    
    private let subscribedKey = "isUserSubscribed"
    
    init() {
        Task {
            await loadInitialState()
            await retrieveProducts()
            await updateSubscriptionStatus()
            await listenForTransactionUpdates()
            self.isLoading = false
            self.isInitialized = true
        }
    }
    
    //MARK: - mock funcions
    
    func loadInitialState() async {
        isSubscribed = UserDefaults.standard.bool(forKey: subscribedKey)
        isLoading = false
    }

    func markUserAsSubscribed() async {
        isLoading.toggle()
        try? await Task.sleep(nanoseconds: 3_000_000_000)
        isSubscribed = true
        UserDefaults.standard.set(true, forKey: subscribedKey)
        isLoading.toggle()
    }

    func resetSubscription() {
        isSubscribed = false
        UserDefaults.standard.set(false, forKey: subscribedKey)
    }
    
    //MARK: - Real funcions
    
    func retrieveProducts() async {

    }
    
    private func updateSubscriptionStatus() async {

    }
    
    func purchase(_ product: Product) async {

    }
    
    func listenForTransactionUpdates() async {

    }
    
    func restorePurchases() async {

    }
}
