//
//  PlantListItemView.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 08.05.2025.
//

import SwiftUI

struct PlantListItemView: View {
    @EnvironmentObject private var viewModel: HomeViewModel
    
    @State var plant = Plant()
    @State var showMenu = false
    
    var body: some View {
        VStack (spacing: 8) {
            ZStack (alignment: .topTrailing) {
                
                GeometryReader { geo in
                    Image("mock")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geo.size.width, height: 144)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                Button(action: {
                    withAnimation(.spring) {
                        showMenu.toggle()
                    }
                }, label: {
                    Circle()
                        .fill(.ultraThinMaterial)
                        .frame(width: 40, height: 40)
                        .overlay(Image(systemName: "ellipsis").foregroundColor(.darkAccent).font(.system(size: 20, weight: .bold)))
                        .padding(4)
                })
                
                if showMenu {
                    PopOver(onDelete: {
                        viewModel.deletePlant(plant)
                    })
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.leading)
                    .padding(.top, 46)
                }
            }
            
            Text(plant.name ?? "Scindapsus")
                .font(.system(size: 16))
                .tracking(2)
                .multilineTextAlignment(.center)
                .frame(height: 42)
            
        }
        .padding(12)
        .frame(maxWidth: .infinity)
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
