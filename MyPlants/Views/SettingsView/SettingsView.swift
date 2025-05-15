//
//  SettingsView.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 08.05.2025.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var notificationManager = NotificationManager()
    @Environment(\.scenePhase) private var scenePhase
    @State var notificationOn = false
    @State private var showShareSheet = false
    
    let appURL = URL(string: "https://example.com/app")!
    let privacyURL = URL(string: "https://docs.google.com/document/d/1wY6VO-Xg6DStAav4ywjC236OuebpvqHqjIliZdMz9LE/edit?usp=sharing")!
    let termsURL = URL(string: "https://docs.google.com/document/d/1HOGEoKmiRYtQK_7kFne9oKCUmijPSSbhrYnzS1hzsAo/edit?usp=sharing")!
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack (spacing: 12) {
                    
                    Toggle(isOn: $notificationManager.notificationsEnabled) {
                        Text("Notifications")
                            .tracking(0.2)
                            .font(.system(size: 16))
                            .foregroundStyle(.darkAccent)
                    }
                    .toggleStyle(SwitchToggleStyle(tint: .darkAccent))
                    .padding()
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .onChange(of: notificationManager.notificationsEnabled) { newValue in
                        if newValue {
                            notificationManager.requestPermission()
                        } else {
                            notificationManager.openAppSettings()
                        }
                    }
                    
                    Link(destination: privacyURL) {
                        SettingsListItem(title: "Privacy policy")
                    }
                    
                    Link(destination: termsURL) {
                        SettingsListItem(title: "Terms of use")
                    }
                    
                    SettingsListItem(title: "Support")
                    
                    Button(action: {
                        showShareSheet = true
                    }) {
                        SettingsListItem(title: "Share app")
                    }
                    .sheet(isPresented: $showShareSheet) {
                        ShareSheet(activityItems: ["Check out this app!", appURL])
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .background(.bg)
            .foregroundStyle(.darkAccent)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Settings")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.darkAccent)
                        .frame(height: 25)
                        .padding(12)
                }
            }
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .active {
                    notificationManager.checkNotificationStatus()
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
