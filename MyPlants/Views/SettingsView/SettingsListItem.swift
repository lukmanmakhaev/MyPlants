//
//  SettingsListItem.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 15.05.2025.
//

import SwiftUI

struct SettingsListItem: View {
    var title: String
    var body: some View {
        HStack {
            Text(title)
                .tracking(0.2)
                .font(.system(size: 16))
                .foregroundStyle(.darkAccent)
            
            Spacer()
        }
        .padding()
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    SettingsListItem(title: "Notifications")
}
