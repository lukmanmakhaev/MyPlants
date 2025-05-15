//
//  OnboardingView.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 15.05.2025.
//

import SwiftUI
import StoreKit


struct OnboardingView: View {
    @EnvironmentObject var subscriptionManager: SubscriptionManager
    @State private var currentStep = 1
    
    
    var body: some View {
        TabView(selection: $currentStep) {
            OnboardingStep(image: "ob1", title: "Plant identification", descr: "Snap or upload photos to accurately identify over 30 000 plants, flowers and trees", currentStep: $currentStep)
                .tag(1)
            
            OnboardingStep(image: "ob2", title: "Your opinion is valuable to us", descr: "Share your experience with the app and help us improve it", currentStep: $currentStep)
                .tag(2)
                .onAppear {
                    if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                        SKStoreReviewController.requestReview(in: scene)
                    }
                }
            
            OnboardingStep(image: "ob3", title: "Diagnostics", descr: "After diagnosing your plant, we will tell you how to treat it", currentStep: $currentStep)
                .tag(3)
            
            SubscriptionView(currentStep: $currentStep)
                .tag(4)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .animation(.easeInOut(duration: 1.0), value: currentStep)
        .transition(.slide)
        .ignoresSafeArea()
    }
}

#Preview {
    OnboardingView()
        .environmentObject(SubscriptionManager())
}
