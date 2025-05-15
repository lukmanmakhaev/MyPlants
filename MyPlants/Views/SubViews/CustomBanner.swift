//
//  CustomBanner.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 15.05.2025.
//

import SwiftUI

struct CustomBanner: View {
    let message: String
    var body: some View {
        VStack {
            Text(message)
                .tracking(0.2)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.darkAccent)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 93)
        .background(Image("bannerBG").resizable().scaledToFill())
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.2), radius: 12, x: 0, y: 6)
        .transition(.move(edge: .top).combined(with: .opacity))
        .animation(.easeInOut(duration: 0.1), value: UUID())
    }
}

#Preview {
    CustomBanner(message: "Plant has been removed\nfrom My garden")
}
