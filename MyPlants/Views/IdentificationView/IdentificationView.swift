//
//  IdentificationView.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 08.05.2025.
//

import SwiftUI

struct IdentificationView: View {
  
    var body: some View {
        VStack (spacing: 16) {
            
            Image("dev")
                .resizable()
                .scaledToFill()
                .frame(height: 343)
                .clipShape(RoundedRectangle(cornerRadius: 24))
            
            IdentificationItem(title: "Scindapsus pictus", percentage: "67,7", image1: "instruction3", image2: "instruction4")
            
            Button(action: {
                
            }, label: {
                Text("Show other similar plants")
                    .tracking(0.2)
                    .padding(16)
                    .font(.system(size: 16, weight: .semibold))
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.main)
            })
        }
        .padding()
        .background(.bg)
    }
}

#Preview {
    IdentificationView()
}
