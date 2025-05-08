//
//  PlantListItemView.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 08.05.2025.
//

import SwiftUI

struct PlantListItemView: View {
    @State var plant = Plant()
    var body: some View {
        VStack (spacing: 8) {
            ZStack (alignment: .topTrailing) {
                
                GeometryReader { geo in
                    Image("mock")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geo.size.width, height: geo.size.height)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                }
                
                Circle()
                    .fill(.ultraThinMaterial)
                    .frame(width: 40, height: 40)
                    .overlay(Image(systemName: "ellipsis").foregroundColor(.primary).font(.system(size: 20, weight: .bold)))
                    .padding(4)
                
            }
            
            Text(plant.name ?? "Scindapsus pictusа")
                .font(.system(size: 16))
                .tracking(2)
                .multilineTextAlignment(.center)
        }
        .padding(12)
        .frame(maxWidth: 166)
        .frame(height: 218)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))

    }
}

#Preview {
    let context = PersistenceController.preview.container.viewContext
    let plant = Plant(context: context)

    return PlantListItemView(plant: plant)
}
