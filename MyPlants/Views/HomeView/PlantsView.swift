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
    
    var body: some View {
        NavigationView {
            
            ScrollView {
                VStack {
                    if viewModel.plants.isEmpty {
                        
                        CameraBannerView()
                            .onTapGesture {
                                viewModel.fetchPlants()
                            }
                        
                    } else {
                        Text("Clean memory")
                            .onTapGesture {
                                viewModel.deleteAllPlants()
                            }
                        
                        List(viewModel.plants) { plant in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(plant.name ?? "Unknown")
                                    .font(.headline)
                                Text(plant.latinName ?? "")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
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
}

#Preview {
    PlantsView()
        .environmentObject(HomeViewModel(context: PersistenceController.shared.container.viewContext))
}
