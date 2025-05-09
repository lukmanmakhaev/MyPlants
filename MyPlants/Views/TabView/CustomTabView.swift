//
//  TabView.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 09.05.2025.
//

import SwiftUI

struct CustomTabView: View {
    @State private var selectedTab: Tab = .home
    
    let persistenceController = PersistenceController.shared
    @StateObject private var viewModel: HomeViewModel
    
    init() {
        let context = persistenceController.container.viewContext
        _viewModel = StateObject(wrappedValue: HomeViewModel(context: context))
    }
    

    var body: some View {
        ZStack(alignment: .bottom) {
            // Direct switch inside the view hierarchy
            switch selectedTab {
            case .home:
                HomeTabView()
            case .camera:
                CameraView()
            case .settings:
                SettingsView()
            }

            TabBar(selectedTab: $selectedTab)
                .padding(.horizontal, 67)
                .padding(.bottom, 60)
                .shadow(color: .black.opacity(0.1), radius: 30, x: 0, y: 4)

        }
        .edgesIgnoringSafeArea(.all)
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
        .environmentObject(viewModel)
    }
}

#Preview {
    CustomTabView()
        .environmentObject(HomeViewModel(context: PersistenceController.shared.container.viewContext))
}
