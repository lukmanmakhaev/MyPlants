//
//  TabBar.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 09.05.2025.
//

import SwiftUI

struct TabBar: View {
    @Binding var selectedTab: Tab

    var body: some View {
        HStack {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                Spacer()
                Button(action: {
                    selectedTab = tab
                }) {
                    Image(tab.rawValue)
                        .resizable()
                        .renderingMode(.template) // Important for color change
                        .frame(width: 24, height: 24)
                        .foregroundColor(selectedTab == tab ? .main : .gray)
                        .scaleEffect(selectedTab == tab ? 1.25 : 1.0)
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.1)) {
                                selectedTab = tab
                            }
                        }
                }
                Spacer()
            }
        }
        .frame(height: 60)
        .background(Color.white)
        .clipShape(Capsule())
    }
}

#Preview {
    TabBar(selectedTab: .constant(.home))
}
