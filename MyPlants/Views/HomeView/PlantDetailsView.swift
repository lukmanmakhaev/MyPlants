//
//  PlantDetailsView.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 13.05.2025.
//

import SwiftUI
import NukeUI

struct PlantDetailsView: View {
    @EnvironmentObject private var homeViewModel: HomeViewModel
    @Environment(\.dismiss) var dismiss
    @State var plant: Plant
    @State var selectedImageUrl: String?
    @State var showMenu = false
    @State var showDeleteAlert = false

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
                    .overlay(alignment: .topTrailing) {
                        if showMenu {
                            PopOver(onDelete: {
                                showDeleteAlert = true
                            })
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding(.top, 52)
                        }
                    }
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    
                    
                    HStack(spacing: 8) {
                        
                        ForEach(plant.imageUrls ?? [], id: \.self) { url in
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
                        
                        Text(plant.name ?? "")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.darkAccent)
                            .tracking(0.2)
                        
                        Spacer()

                    }
                    .padding(.bottom, 4)
                    
                    
                    VStack (alignment: .leading, spacing: 8) {
                        Text("Description")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.darkAccent)
                            .tracking(0.2)
                        
                        Text(plant.descriptionText ?? "")
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
                        
                        TaxonomyRow(title: "Kingdom:", value: plant.kingdom ?? "")
                        
                        Divider()
                            .opacity(0.4)
                        
                        TaxonomyRow(title: "Phylum:", value: plant.phylum ?? "")
                        
                        Divider()
                            .opacity(0.4)
                        
                        TaxonomyRow(title: "Class:", value: plant.plantClass ?? "")
                        
                        Divider()
                            .opacity(0.4)
                        
                        TaxonomyRow(title: "Order:", value: plant.order ?? "")
                        
                        Divider()
                            .opacity(0.4)
                        
                        TaxonomyRow(title: "Family:", value: plant.family ?? "")
                        
                        Divider()
                            .opacity(0.4)
                        
                        TaxonomyRow(title: "Genus:", value: plant.genus ?? "")
                        
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
                
                Button(action: {
                    showMenu.toggle()
                }) {
                    Circle()
                        .fill(.ultraThinMaterial)
                        .frame(width: 48, height: 48)
                        .overlay(Image(systemName: "ellipsis").foregroundColor(.darkAccent).font(.system(size: 19, weight: .semibold)))
                }
            }
            .padding()
            
        }
        .background(.bg)
        .onAppear {
            selectedImageUrl = plant.imageUrls?.first ?? ""
        }
        .alert("Do you really want to delete the plant?", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                homeViewModel.deletePlant(plant)
            }
        } message: {
            Text("This action cannot be undone")
        }
    }
}

//#Preview {
//    PlantDetailsView(plant: PlantData(name: "Scindapsus pictus", commonName: "Satin pothos", description: "Scindapsus pictus, or silver vine, is a species of flowering plant in the arum family Araceae, native to India, Bangladesh, Thailand, Peninsular Malaysia, Borneo, Java, Sumatra, Sulawesi, and the Philippines. \n\nGrowing to 3 m (10 ft) tall in open ground, it is an evergreen climber. The leaves are matte green and covered in silver blotches. The insignificant flowers are rarely seen in cultivation. The Latin specific epithet pictus means 'painted', referring to the variegation on the leaves.\n\nWith a minimum temperature tolerance of 15 °C (59 °F), this plant is cultivated as a houseplant in temperate regions, where it typically grows to 90 cm (35 in).", kingdom: "Plantae", phylum: "Tracheophyta", plantClass: "Liliopsida", probability: 0.679, order: "Alismatales", family: "Araceae", genus: "Scindapsus", imageUrls: []))
//}
