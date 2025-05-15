//
//  ContentView.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 08.05.2025.
//

import SwiftUI
import CoreData

struct HomeTabView: View {
    @State private var selectedHomeTab: HomeTab = .plants
    @Binding var selectedTab: Tab
    @EnvironmentObject private var homeViewModel: HomeViewModel
    
    
    var body: some View {
        NavigationView {
            VStack (spacing: 8) {
                HStack(spacing: 8) {
                    Button(action: {
                        selectedHomeTab = .plants
                    }) {
                        Text("Plants")
                            .font(.system(size: 16))
                            .fontWeight(selectedHomeTab == .plants ? .semibold : .regular)
                            .foregroundColor(selectedHomeTab == .history ? .black : .white)
                            .frame(width: 120, height: 44)
                            .background(selectedHomeTab == .plants ? Color.main : Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                    }
                    
                    Button(action: {
                        selectedHomeTab = .history
                    }) {
                        Text("History")
                            .font(.system(size: 16))
                            .fontWeight(selectedHomeTab == .history ? .semibold : .regular)
                            .foregroundColor(selectedHomeTab == .history ? .white : .black)
                            .frame(width: 120, height: 44)
                            .background(selectedHomeTab == .history ? Color.main : Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                    }
                }
                .padding(.horizontal, 63)
                
                TabView(selection: $selectedHomeTab) {
                    PlantsView(selectedTab: $selectedTab)
                        .environmentObject(homeViewModel)
                        .tag(HomeTab.plants)
                    
                    HistoryView(selectedTab: $selectedTab)
                        .environmentObject(homeViewModel)
                        .tag(HomeTab.history)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(.easeInOut(duration: 1.0), value: selectedHomeTab)
            }
            .background(.bg)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .edgesIgnoringSafeArea(.bottom)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("My garden")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.darkAccent)
                        .frame(height: 25)
                        .padding(12)
                }
            }
        }
    }
}


#Preview {
    HomeTabView(selectedTab: .constant(.home))
        .environmentObject(HomeViewModel(repository: CoreDataPlantRepository(context: PersistenceController.shared.container.viewContext)))
}
