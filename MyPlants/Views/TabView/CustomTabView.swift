//
//  TabView.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 09.05.2025.
//

import SwiftUI

struct CustomTabView: View {
    let persistenceController = PersistenceController.shared
    
    @StateObject private var homeViewModel: HomeViewModel
    @StateObject private var cameraViewModel = CameraViewModel()
    
    @State private var selectedTab: Tab = .home
    
    init() {
        let context = persistenceController.container.viewContext
        _homeViewModel = StateObject(wrappedValue: HomeViewModel(context: context))
    }
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            switch selectedTab {
            case .home:
                HomeTabView()
                    .environmentObject(homeViewModel)
                
            case .camera:
                CameraView ()
                    .environmentObject(cameraViewModel)
                
            case .settings:
                SettingsView()
            }
            
            TabBar(selectedTab: $selectedTab)
                .padding(.horizontal, 67)
                .padding(.bottom, 50)
                .shadow(color: .black.opacity(0.1), radius: 30, x: 0, y: 4)
            
        }
        .edgesIgnoringSafeArea(.all)
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
}

#Preview {
    CustomTabView()
        .environmentObject(HomeViewModel(context: PersistenceController.shared.container.viewContext))
}
