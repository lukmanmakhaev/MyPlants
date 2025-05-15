//
//  TaxonomyRow.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 13.05.2025.
//

import SwiftUI

struct TaxonomyRow: View {
    var title: String
    var value: String
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 14))
                .tracking(0.2)
                .frame(width: 80, alignment: .leading)
                .foregroundColor(.main)
            
            Text(value)
                .font(.system(size: 12))
                .foregroundColor(.darkAccent)
                .tracking(0.2)
        }
    }
}

#Preview {
    TaxonomyRow(title: "", value: "")
}
