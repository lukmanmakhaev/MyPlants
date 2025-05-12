//
//  InstructionsItem.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 12.05.2025.
//

import SwiftUI

struct InstructionItem: View {
    var title: String
    var description: String
    var image1: String
    var image2: String
    
    var body: some View {
        VStack (spacing: 8) {
            
            Text(title)
                .font(.system(size: 14))
                .foregroundColor(.black)
                .tracking(0.2)
            + Text("\n\(description)")
                .font(.system(size: 14))
                .foregroundColor(.iconsTertiary)
                .tracking(0.2)
            
            
            HStack (spacing: 9) {
                Image(image1)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                Image(image2)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }

        }
        .frame(height: 245)
        .frame(maxWidth: .infinity)
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .multilineTextAlignment(.center)
        .lineSpacing(2)
    }
}

#Preview {
    InstructionItem(title: "123", description: "123", image1: "123", image2: "123")
}
