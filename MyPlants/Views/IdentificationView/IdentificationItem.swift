//
//  IdentificationItem.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 12.05.2025.
//

import SwiftUI
import NukeUI


struct IdentificationItem: View {
    @EnvironmentObject private var homeViewModel: HomeViewModel
    var suggestion: Suggestion
    var inputImageUrl: String
    
    var body: some View {
        
        VStack (spacing: 12) {
            
            HStack {
                
                Text(suggestion.name)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                    .tracking(0.2)
                
                Spacer()
                
                Text(String(format: "%.1f%%", suggestion.probability * 100))
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .tracking(0.2)
                    .frame(width: 70)
                    .padding(.vertical, 10)
                    .background(.accentPurple)
                    .clipShape(Capsule())
            }
              
            HStack(spacing: 7) {
                
                LazyImage(url: URL(string: suggestion.similarImages?.first?.url ?? "")) { state in
                    if let image = state.image {
                        image
                            .resizable()
                            .scaledToFill()
                    } else if state.error != nil {
                        Color.colorGray
                    } else {
                        ProgressView()
                    }
                }
                .frame(height: 153)
                .frame(maxWidth: .infinity)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 16))
                
                LazyImage(url: URL(string: suggestion.similarImages?.dropFirst().first?.url ?? "")) { state in
                    if let image = state.image {
                        image
                            .resizable()
                            .scaledToFill()
                    } else if state.error != nil {
                        Color.colorGray
                    } else {
                        ProgressView()
                    }
                }
                .frame(height: 153)
                .frame(maxWidth: .infinity)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            
            HStack (spacing: 8) {
                
                NavigationLink(destination: {
                    IdentificationDetailsView(inputImageUrl: inputImageUrl, suggestion: suggestion)
                        .environmentObject(homeViewModel)
                }, label: {
                    Text("More info")
                        .tracking(0.2)
                        .padding(16)
                        .font(.system(size: 16, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.main)
                        .overlay(
                            Capsule()
                                .stroke(.main, lineWidth: 2)
                        )
                        .clipShape(Capsule())
                })
                
                Button(action: {
                    homeViewModel.togglePlant(from: suggestion, inputImageUrl: inputImageUrl)

                }) {
                    Text(homeViewModel.contains(suggestion) ? "Remove" : "To my garden")
                        .tracking(0.2)
                        .padding(16)
                        .font(.system(size: 16, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .background(.main)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                }
            }
        }
        .padding()
        .frame(height: 289)
        .background()
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .multilineTextAlignment(.center)
        .lineSpacing(2)
    }
}

//#Preview {
//    IdentificationItem(suggestion: Suggestion(id: "", name: "", source: "", probability: 12.2, similarImages: nil, details: nil))
//        .environmentObject(HomeViewModel())
//}
