//
//  MyPlantsApp.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 08.05.2025.
//

import SwiftUI
import CoreData

@main
struct MyPlantsApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var viewModel: HomeViewModel
    
    init() {
        let context = persistenceController.container.viewContext
        _viewModel = StateObject(wrappedValue: HomeViewModel(context: context))
    }

    var body: some Scene {
        WindowGroup {
            HomeTabView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(HomeViewModel(context: persistenceController.container.viewContext))
        }
    }
}

