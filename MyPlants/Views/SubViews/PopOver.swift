//
//  PopOver.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 09.05.2025.
//

import SwiftUI

struct PopOver: View {
    var onDelete: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button(action: {
                print("Rename tapped")
            }) {
                HStack(spacing: 8) {
                    Image("pen")
                        .resizable()
                        .renderingMode(.template)
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                    
                    Text("Rename")
                        .font(.system(size: 14))
                }
            }
            .foregroundStyle(.darkAccent)
            
            Divider()
                .padding(.vertical, 12.5)
            
            Button(action: {
                onDelete()
                print("Delete tapped")
            }, label: {
                HStack(spacing: 8) {
                    Image("trash")
                        .resizable()
                        .renderingMode(.template)
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                    
                    Text("Delete")
                        .font(.system(size: 14))
                }
            })
            .foregroundStyle(.darkAccent)
        }
        .padding()
        .background(.white)
        .fixedSize(horizontal: true, vertical: false)
    }
}

#Preview {
    PopOver(onDelete: {
        print("delete tapped")
    })
}
