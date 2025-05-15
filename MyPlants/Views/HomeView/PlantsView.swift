//
//  HomeView.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 08.05.2025.
//

import SwiftUI
import CoreData

struct PlantsView: View {
    @EnvironmentObject private var homeViewModel: HomeViewModel
    @Binding var selectedTab: Tab
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ScrollView (showsIndicators: false) {
            VStack {
                if homeViewModel.plants.isEmpty {
                    CameraBannerView(selectedTab: $selectedTab)
                    
                } else {
                    
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(homeViewModel.plants) { plant in
                            NavigationLink(destination: {
                                PlantDetailsView(plant: plant)
                            }, label: {
                                PlantListItemView(plant: plant)
                                    .environmentObject(homeViewModel)
                            })
                            .foregroundStyle(.darkAccent)
                        }
                    }
                }
            }
            .padding(.top, 12)
            .padding(.horizontal, 16)
        }
        .frame(maxWidth: .infinity)
        .background(.bg)
    }
}

#Preview {
    PlantsView(selectedTab: .constant(.home))
        .environmentObject(HomeViewModel(repository: CoreDataPlantRepository(context: PersistenceController.shared.container.viewContext)))
}
