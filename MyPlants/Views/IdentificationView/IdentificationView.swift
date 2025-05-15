//
//  IdentificationView.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 08.05.2025.
//

import SwiftUI
import NukeUI

struct IdentificationView: View {
    let result: PlantIDResponse
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var cameraViewModel: CameraViewModel
    @EnvironmentObject private var identificationVM: IdentificationViewModel
    @EnvironmentObject private var homeViewModel: HomeViewModel
    @State private var showAllSuggestions = false
    @State var isShowingGuide: Bool = false
    
    var body: some View {
        VStack {
            ScrollView {
                VStack (spacing: 16) {
                    
                    LazyImage(url: URL(string: result.input.images.first ?? "")) { state in
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
                    .frame(height: 343)
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    
                    ForEach(
                        showAllSuggestions ? result.result.classification.suggestions : [result.result.classification.suggestions.first].compactMap { $0 },
                        id: \.id
                    ) { suggestion in
                        IdentificationItem(suggestion: suggestion, inputImageUrl: result.input.images.first ?? "")
                            .environmentObject(homeViewModel)
                    }
                    
                    if !showAllSuggestions {
                        Button(action: {
                            withAnimation {
                                showAllSuggestions = true
                            }
                        }, label: {
                            Text("Show other similar plants")
                                .tracking(0.2)
                                .padding(16)
                                .font(.system(size: 16, weight: .semibold))
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(.main)
                        })
                    } else {
                        FailureBannerView(title: "Has your plant been identified incorrectly?", isShowingGuide: $isShowingGuide)
                            .environmentObject(cameraViewModel)
                            .environmentObject(identificationVM)
                    }
                }
                .padding()
            }
            .background(.bg)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image("arrow")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .rotationEffect(.degrees(180))
                        .foregroundColor(.darkAccent)
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("Species identification")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.darkAccent)
                    .frame(height: 25)
                    .padding(12)
            }
        }
    }
}


#Preview {
    IdentificationView(result: PlantIDResponse(accessToken: "", modelVersion: "", input: PlantInput(latitude: 0.0, longitude: 0.0, similarImages: true, images: [], datetime: ""), result: PlantResult(isPlant: nil, classification: Classification(suggestions: [])), status: ""))
}
