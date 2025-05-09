//
//  ContentView.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 08.05.2025.
//

import SwiftUI
import CoreData

struct HomeTabView: View {
    @State private var selectedTab: HomeTab = .plants
    @EnvironmentObject private var viewModel: HomeViewModel
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(spacing: 8) {
                    Button(action: {
                        selectedTab = .plants
                    }) {
                        Text("Plants")
                            .font(.system(size: 16))
                            .fontWeight(selectedTab == .plants ? .semibold : .regular)
                            .foregroundColor(selectedTab == .history ? .black : .white)
                            .frame(width: 120, height: 44)
                            .background(selectedTab == .plants ? Color.accentColor : Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                    }
                    
                    Button(action: {
                        selectedTab = .history
                    }) {
                        Text("History")
                            .font(.system(size: 16))
                            .fontWeight(selectedTab == .history ? .semibold : .regular)
                            .foregroundColor(selectedTab == .history ? .white : .black)
                            .frame(width: 120, height: 44)
                            .background(selectedTab == .history ? Color.accentColor : Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                    }
                }
                .padding(.horizontal, 63)
                .padding(.bottom, 12)
                
                TabView(selection: $selectedTab) {
                    PlantsView()
                        .environment(\.managedObjectContext, viewContext)
                        .environmentObject(viewModel)
                        .tag(HomeTab.plants)
                    
                    HistoryView()
                        .environment(\.managedObjectContext, viewContext)
                        .environmentObject(viewModel)
                        .tag(HomeTab.history)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(.easeInOut(duration: 1.0), value: selectedTab)  
            }
            .background(.bg)
            .navigationTitle("My garden")
            .navigationBarTitleDisplayMode(.inline)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}


#Preview {
    HomeTabView()
        .environmentObject(HomeViewModel(context: PersistenceController.shared.container.viewContext))
    
    
}
