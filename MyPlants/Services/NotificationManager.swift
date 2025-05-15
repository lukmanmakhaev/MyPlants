//
//  NotificationManager.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 15.05.2025.
//

import Foundation
import UserNotifications
import SwiftUI

final class NotificationManager: ObservableObject {
    @Published var notificationsEnabled: Bool = false
    
    init() {
        checkNotificationStatus()
    }
    
    func checkNotificationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.notificationsEnabled = settings.authorizationStatus == .authorized
            }
        }
    }
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
            DispatchQueue.main.async {
                self.notificationsEnabled = granted
            }
        }
    }
    
    func openAppSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
    }
}
