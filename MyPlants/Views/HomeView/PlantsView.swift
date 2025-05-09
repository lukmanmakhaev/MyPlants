//
//  HomeView.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 08.05.2025.
//

import SwiftUI
import CoreData

struct PlantsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject private var viewModel: HomeViewModel
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Plant.createdAt, ascending: false)],
        animation: .default
    )
    private var plants: FetchedResults<Plant>
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ScrollView (showsIndicators: false) {
            VStack {
                if plants.isEmpty {
                    
                    CameraBannerView()
                    
                    Text("Add Mock Plants")
                        .onTapGesture {
                            viewModel.addMockPlants()
                        }
                    
                } else {
                    
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(plants) { plant in
                            PlantListItemView(plant: plant)
                                .environmentObject(viewModel)
                        }
                    }
                }
            }
            .padding(8)
            .padding(.horizontal, 8)
        }
        .frame(maxWidth: .infinity)
        .background(.bg)
    }
}

//#Preview {
//    PlantsView()
//        .environmentObject(HomeViewModel(context: PersistenceController.shared.container.viewContext))
//}
