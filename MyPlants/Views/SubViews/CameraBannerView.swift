//
//  CameraBannerView.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 08.05.2025.
//

import SwiftUI

struct CameraBannerView: View {
    @EnvironmentObject private var homeViewModel: HomeViewModel
    @Binding var selectedTab: Tab
    
    var body: some View {
        VStack (spacing: 12) {
            VStack (spacing: 4){
                Text("There are no plants in your garden yet")
                    .font(.system(size: 14))
                    .foregroundColor(.iconsTertiary2)
                
                Text("Identify your first plant using the camera or\nupload a photo")
                    .font(.system(size: 14))
                    .foregroundColor(.darkAccent)
                    .multilineTextAlignment(.center)
            }
            
            Button(action: {
                selectedTab = .camera
            }, label: {
                Text("Open the camera")
                    .foregroundStyle(.white)
                    .font(.system(size: 16, weight: .semibold))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.main)
                    .clipShape(.capsule)
                    .padding(.horizontal, 35)
            })
        }
        .padding(16)
        .padding(.vertical, 8)
        .overlay(alignment: .bottomLeading, content: {
            Image(.banner1)
                .resizable()
                .scaledToFit()
                .frame(width: 90, height: 60)
        })
        .overlay(alignment: .topTrailing, content: {
            Image(.banner2)
                .resizable()
                .scaledToFit()
                .frame(width: 102, height: 42)
        })
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    CameraBannerView(selectedTab: .constant(.home))
}
