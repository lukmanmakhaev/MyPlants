//
//  IdentificationItem.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 12.05.2025.
//

import SwiftUI

struct IdentificationItem: View {
    var title: String
    var percentage: String
    var image1: String
    var image2: String
    
    var body: some View {
        VStack (spacing: 12) {
            
            HStack {
                Text(title)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                    .tracking(0.2)
                
                Spacer()
                
                Text("\(percentage)%")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .tracking(0.2)
                    .frame(width: 70)
                    .padding(.vertical, 10)
                    .background(.accentPurple)
                    .clipShape(Capsule())
            }


            
            
            HStack(spacing: 7) {
                Image(image1)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 153)
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                Image(image2)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 153)
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            
            HStack (spacing: 8) {
                Button(action: {
                    
                }) {
                    Text("More info")
                        .tracking(0.2)
                        .padding(16)
                        .font(.system(size: 16, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.main)
                        .overlay(
                            Capsule()
                                .stroke(.main, lineWidth: 2)
                        )
                        .clipShape(Capsule())
                    
                }
                
                Button(action: {
                    
                }) {
                    Text("To my garden")
                        .tracking(0.2)
                        .padding(16)
                        .font(.system(size: 16, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .background(.main)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                }
            }

        }
        .padding()
        .frame(height: 289)
        .background()
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .multilineTextAlignment(.center)
        .lineSpacing(2)
    }
}

#Preview {
    IdentificationItem(title: "Scindapsus pictus", percentage: "67,6", image1: "instruction", image2: "instruction2")
}
