//
//  NotificationViewModel.swift
//  ReportViewer
//
//  Created by admin on 23/06/25.
//

import Foundation
import UserNotifications

class NotificationViewModel: ObservableObject {
    @Published var isEnabled: Bool = true {
        didSet {
            UserDefaults.standard.set(isEnabled, forKey: "notifications_enabled")
        }
    }

    init() {
        self.isEnabled = UserDefaults.standard.bool(forKey: "notifications_enabled")
    }

    func requestPermission() {
        NotificationService.requestPermission { granted in
            DispatchQueue.main.async {
                self.isEnabled = granted
            }
        }
    }

    func notify(title: String, message: String) {
        guard isEnabled else { return }
        NotificationService.schedule(title: title, message: message)
    }
}

