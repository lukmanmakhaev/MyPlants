//
//  HistoryView.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 08.05.2025.
//

import SwiftUI

struct HistoryView: View {
    var body: some View {
        NavigationView {
            
            ScrollView {
                VStack {
                    CameraBannerView()
                }
                .padding(8)
                .padding(.horizontal, 8)
            }
            .frame(maxWidth: .infinity)
            .background(.bg)
        }
    }
}

#Preview {
    HistoryView()
}
