//
//  InstructionsView.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 11.05.2025.
//

import SwiftUI

struct InstructionsView: View {
    var body: some View {
        ScrollView (showsIndicators: false) {
            VStack (spacing: 12) {
                Text("Tips on how to take a photo")
                    .font(.system(size: 20, weight: .semibold))
                    .padding()
                
                InstructionItem(title: "Place your plant at the center of the frame.", description: "Steer clear of gloomy, overly bright,\n or blurry images.", image1: "instruction", image2: "instruction2")
                
                InstructionItem(title: "If the plant is too fit in the frame.", description: "Take a photo of its leaves or flowers.", image1: "instruction3", image2: "instruction4")
                
                InstructionItem(title: "Don’t get your camera too close to the plant.", description: "Make sure to keep at least one whole leaf or flower in focus.", image1: "instruction5", image2: "instruction6")
            }
            .padding(.bottom, 42)
        }
        .padding()
        .background(.colorGray)
        .ignoresSafeArea(.all)
        
    }
}

#Preview {
    InstructionsView()
}
