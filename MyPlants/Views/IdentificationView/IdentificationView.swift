//
//  IdentificationView.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 08.05.2025.
//

import SwiftUI

struct IdentificationView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject private var viewModel: HomeViewModel
    
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    TextField("Название растения", text: $viewModel.name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Название растения", text: $viewModel.latinName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Название растения", text: $viewModel.descriptionText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("Добавить") {
                        viewModel.addPlant()
                    }
                }
                .padding()
                
                List(viewModel.plants, id: \.id) { plant in
                    VStack(alignment: .leading) {
                        Text(plant.name ?? "")
                            .font(.headline)
                        if let date = plant.createdAt {
                            Text(date.formatted(date: .abbreviated, time: .shortened))
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Мои растения")
        }
    }
}

#Preview {
    IdentificationView()
        .environmentObject(HomeViewModel(context: PersistenceController.shared.container.viewContext))
}
