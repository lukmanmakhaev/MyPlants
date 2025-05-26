//
//  SubscriptionView.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 15.05.2025.
//

import SwiftUI

struct SubscriptionView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var subscriptionManager: SubscriptionManager
    
    let privacyURL = URL(string: "https://docs.google.com/document/d/1wY6VO-Xg6DStAav4ywjC236OuebpvqHqjIliZdMz9LE/edit?usp=sharing")!
    let termsURL = URL(string: "https://docs.google.com/document/d/1HOGEoKmiRYtQK_7kFne9oKCUmijPSSbhrYnzS1hzsAo/edit?usp=sharing")!
    
    @State var subsText: String = "Enable a 3-day free trial"
    @State var descriptionText: String = "Subscribe to unlock all the features,\njust for $4.99/week"
    
    @State var isOn = false
    @Binding var currentStep: Int
    @State private var rotation: Double = 0

    
    var body: some View {
        ZStack (alignment: .top) {
            Image(.subs)
                .resizable()
                .scaledToFill()
                .frame(height: 472)
            
            VStack (spacing: 12) {
                Spacer()
                
                VStack(spacing: 12) {
                    Image(.subs1)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 80)
                        .padding(24)
                    
                    Text("Identification without restrictions")
                        .tracking(0.2)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.darkAccent)
                    
                    Text(descriptionText)
                        .tracking(0.2)
                        .font(.system(size: 14))
                        .foregroundStyle(.iconsTertiary2)
                        .multilineTextAlignment(.center)
                    
                    Toggle(isOn: $isOn) {
                        Text(subsText)
                            .tracking(0.2)
                            .font(.system(size: 14))
                            .foregroundStyle(.darkAccent)
                    }
                    .toggleStyle(SwitchToggleStyle(tint: .darkAccent))
                    .padding(12)
                    .frame(maxWidth: .infinity)
                    .frame(height: subscriptionManager.isLoading ? 0 : 55)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .animation(.easeInOut(duration: 0.3), value: subsText)
                    .animation(.easeInOut(duration: 0.3), value: subscriptionManager.isLoading)
                    
                    Button(action: {
                        Task {
                            await subscriptionManager.markUserAsSubscribed()
                        }
                    }, label: {
                        if subscriptionManager.isLoading {
                            Image(.loader)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .scaledToFit()
                                .rotationEffect(.degrees(rotation))
                                .onAppear {
                                    withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                                        rotation = 360
                                    }
                                }
                                .onDisappear {
                                    rotation = 0
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(.main)
                                .clipShape(.capsule)
                            
                        } else {
                            Text("Continue")
                                .foregroundStyle(.white)
                                .font(.system(size: 16, weight: .semibold))
                                .frame(height: 24)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(.main)
                                .clipShape(.capsule)
                        }
                    })
                }
                .padding(.horizontal)
                .padding(.top, 12)
                .animation(.easeInOut(duration: 0.3), value: subscriptionManager.isLoading)
                
                
                HStack {
                    Link(destination: termsURL) {
                        Text("Terms of Use")
                            .tracking(0.2)
                            .foregroundStyle(.iconsTertiary)
                            .font(.system(size: 14))
                    }
                    
                    Spacer()
                    
                    Text("Restore")
                        .tracking(0.2)
                        .foregroundStyle(.iconsTertiary)
                        .font(.system(size: 14))
                    
                    Spacer()
                    
                    Link(destination: privacyURL) {
                        Text("Privacy Policy")
                            .tracking(0.2)
                            .foregroundStyle(.iconsTertiary)
                            .font(.system(size: 14))
                    }
                }
                .frame(height: 40)
                .padding(.horizontal, 26)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.bg)
        .overlay(alignment: .topTrailing) {
            if !subscriptionManager.isLoading {
                Button(action: {
                    currentStep = 3
                }, label: {
                    ZStack {
                        Circle()
                            .fill(.white)
                            .frame(width: 48, height: 48)
                        Image(.close)
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.iconsTertiary)
                            .frame(width: 24, height: 24)
                    }
                })
                .padding(4)
                .padding(.horizontal, 16)
            }
        }
        .onChange(of: isOn) { newValue in
            if isOn {
                subsText = "3-day free trial enabled"
            } else {
                subsText = "Enable a 3-day free trial"
            }
        }
        .onChange(of: subscriptionManager.isLoading) { newValue in
            descriptionText = "Subscribe to unlock all the features, just for $119.99 at one time"
        }
        .animation(.easeInOut(duration: 0.3), value: descriptionText)
    }
}

#Preview {
    SubscriptionView(currentStep: .constant(4))
        .environmentObject(SubscriptionManager())
}
