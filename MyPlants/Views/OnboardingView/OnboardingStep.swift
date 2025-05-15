//
//  OnboardingStep.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 15.05.2025.
//

import SwiftUI

struct OnboardingStep: View {
    let privacyURL = URL(string: "https://docs.google.com/document/d/1wY6VO-Xg6DStAav4ywjC236OuebpvqHqjIliZdMz9LE/edit?usp=sharing")!
    let termsURL = URL(string: "https://docs.google.com/document/d/1HOGEoKmiRYtQK_7kFne9oKCUmijPSSbhrYnzS1hzsAo/edit?usp=sharing")!
    
    var image: String
    var title: String
    var descr: String
    
    @Binding var currentStep: Int
    @State var isSubsPresented: Bool = false

    
    var body: some View {
        VStack (spacing: 12) {
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(height: 539)
            
            VStack(spacing: 8) {
                Text(title)
                    .tracking(0.2)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.darkAccent)
                
                Text(descr)
                    .tracking(0.2)
                    .font(.system(size: 14))
                    .foregroundStyle(.iconsTertiary2)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            Button(action: {
                currentStep += 1
            }, label: {
                Text("Continue")
                    .foregroundStyle(.white)
                    .font(.system(size: 16, weight: .semibold))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.main)
                    .clipShape(.capsule)
            })
            .padding(.horizontal)
            
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
        .background(.bg)
    }
}

#Preview {
    OnboardingStep(image: "ob1", title: "Plant identification", descr: "Snap or upload photos to accurately identify over 30 000 plants, flowers and trees", currentStep: .constant(1))
}
