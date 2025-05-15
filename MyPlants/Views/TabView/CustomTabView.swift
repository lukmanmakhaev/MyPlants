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
    @StateObject private var identificationVM = IdentificationViewModel()
    
    @State private var selectedTab: Tab = .home
    
    
    init() {
        let context = persistenceController.container.viewContext
        let repository = CoreDataPlantRepository(context: context)
        _homeViewModel = StateObject(wrappedValue: HomeViewModel(repository: repository))
        _cameraViewModel = StateObject(wrappedValue: CameraViewModel())
    }
    
    
    var body: some View {
        ZStack(alignment: .top) {
            NavigationView {
                ZStack(alignment: .bottom) {
                    switch selectedTab {
                    case .home:
                        HomeTabView(selectedTab: $selectedTab)
                            .environmentObject(homeViewModel)
                        
                    case .camera:
                        CameraView()
                            .environmentObject(cameraViewModel)
                            .environmentObject(homeViewModel)
                            .environmentObject(identificationVM)
                        
                    case .settings:
                        SettingsView()
                    }
                    
                    TabBar(selectedTab: $selectedTab)
                        .padding(.horizontal, 67)
                        .padding(.bottom, 50)
                        .shadow(color: .black.opacity(0.1), radius: 30, x: 0, y: 4)
                    
                    NavigationLink(
                        isActive: $identificationVM.showResult,
                        destination: {
                            ResultView()
                                .environmentObject(homeViewModel)
                                .environmentObject(cameraViewModel)
                                .environmentObject(identificationVM)
                        },
                        label: {
                            EmptyView()
                        }
                    )
                }
                .ignoresSafeArea(.all, edges: .bottom)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
            
            if homeViewModel.showBanner {
                CustomBanner(message: homeViewModel.bannerMessage)
                    .padding(.horizontal)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .animation(.easeInOut(duration: 0.3), value: homeViewModel.showBanner)
                    .zIndex(10)
            }
        }
    }
}

#Preview {
    CustomTabView()
        .environmentObject(HomeViewModel(repository: CoreDataPlantRepository(context: PersistenceController.shared.container.viewContext)))
        .environmentObject(IdentificationViewModel())
}
