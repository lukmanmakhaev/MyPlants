//
//  HistoryView.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 08.05.2025.
//

import SwiftUI

struct HistoryView: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        NavigationView {
            
            ScrollView {
                VStack {
                    CameraBannerView(selectedTab: $selectedTab)
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
    HistoryView(selectedTab: .constant(.home))
}
