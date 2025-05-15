//
//  IdentificationDetailsView.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 14.05.2025.
//

import SwiftUI
import NukeUI

struct IdentificationDetailsView: View {
    @EnvironmentObject private var homeViewModel: HomeViewModel
    @Environment(\.dismiss) var dismiss
    @State var selectedImageUrl: String?

    var inputImageUrl: String
    var suggestion: Suggestion
    
    var body: some View {
        ZStack (alignment: .top) {
            ScrollView (showsIndicators: false) {
                
                VStack (spacing: 12) {
                    LazyImage(url: URL(string: selectedImageUrl ?? "")) { state in
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
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    
                    
                    HStack(spacing: 8) {
                        
                        LazyImage(url: URL(string: inputImageUrl)) { state in
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
                        .frame(height: 109)
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .overlay {
                            if selectedImageUrl == inputImageUrl {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.accentPurple, lineWidth: 2)
                            }
                        }
                        .onTapGesture {
                            selectedImageUrl = inputImageUrl
                        }
     
                        ForEach(suggestion.similarImages?.prefix(2).compactMap{ $0.url } ?? [], id: \.self) { url in
                            LazyImage(url: URL(string: url)) { state in
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
                            .frame(height: 109)
                            .frame(maxWidth: .infinity)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .overlay {
                                if selectedImageUrl == url {
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.accentPurple, lineWidth: 2)
                                }
                            }
                            .onTapGesture {
                                selectedImageUrl = url
                            }
                        }
                    }
                    .frame(height: 109)
                    .frame(maxWidth: .infinity)
                    
                    HStack {
                        
                        VStack (alignment: .leading, spacing: 4) {
                            Text(suggestion.name)
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.darkAccent)
                                .tracking(0.2)
                            
                            Text(suggestion.details?.commonNames?.first ?? "")
                                .font(.system(size: 14))
                                .foregroundColor(.iconsTertiary)
                                .tracking(0.2)
                        }
                        
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
                    .padding(.bottom, 4)
                    
                    
                    VStack (alignment: .leading, spacing: 8) {
                        Text("Description")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.darkAccent)
                            .tracking(0.2)
                        
                        Text(suggestion.details?.description?.value ?? "")
                            .font(.system(size: 14))
                            .tracking(0.2)
                            .lineSpacing(5)
                            .foregroundColor(.darkAccent)
                    }
                    .padding(12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    VStack (alignment: .leading, spacing: 8) {
                        Text("Taxonomy")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.darkAccent)
                            .tracking(0.2)
                        
                        TaxonomyRow(title: "Kingdom:", value: suggestion.details?.taxonomy?.kingdom ?? "")
                        
                        Divider()
                            .opacity(0.4)
                        
                        TaxonomyRow(title: "Phylum:", value: suggestion.details?.taxonomy?.phylum ?? "")
                        
                        Divider()
                            .opacity(0.4)
                        
                        TaxonomyRow(title: "Class:", value: suggestion.details?.taxonomy?.class ?? "")
                        
                        Divider()
                            .opacity(0.4)
                        
                        TaxonomyRow(title: "Order:", value: suggestion.details?.taxonomy?.order ?? "")
                        
                        Divider()
                            .opacity(0.4)
                        
                        TaxonomyRow(title: "Family:", value: suggestion.details?.taxonomy?.family ?? "")
                        
                        Divider()
                            .opacity(0.4)
                        
                        TaxonomyRow(title: "Genus:", value: suggestion.details?.taxonomy?.genus ?? "")
                        
                    }
                    .padding(12)
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                }
                .padding(.bottom, 80)
                .padding()
                .navigationBarBackButtonHidden(true)
            }
            
            VStack {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Circle()
                            .fill(.ultraThinMaterial)
                            .frame(width: 48, height: 48)
                            .overlay(Image(systemName: "chevron.left").foregroundColor(.darkAccent).font(.system(size: 19, weight: .semibold)))
                    }
                    
                    Spacer()
                
                }
                
                Spacer()
                
                Button(action: {
                    homeViewModel.togglePlant(from: suggestion, inputImageUrl: inputImageUrl)
                }, label: {
                    Text(homeViewModel.contains(suggestion) ? "Remove from my garden" : "Add to my garden")
                        .foregroundStyle(.white)
                        .font(.system(size: 16, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.main)
                        .clipShape(.capsule)
                })
            }
            .padding()
            
        }
        .background(.bg)
        .onAppear {
            selectedImageUrl = inputImageUrl
        }
    }
}

#Preview {
    IdentificationDetailsView(inputImageUrl: "", suggestion: Suggestion(id: "", name: "", source: "", probability: 0.0, similarImages: nil, details: nil))
}
