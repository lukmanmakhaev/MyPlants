//
//  LoadingView.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 14.05.2025.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.bg.ignoresSafeArea()
            GIFImageView("loading")
                .padding(16)
                .padding(.top, 104)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    LoadingView()
}
