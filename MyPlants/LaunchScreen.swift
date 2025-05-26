//
//  LaunchScreen.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 26.05.2025.
//

import SwiftUI

struct LaunchScreen: View {
    var body: some View {
        ZStack {
            Image(.launchScreen)
                .resizable()
        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    LaunchScreen()
}
