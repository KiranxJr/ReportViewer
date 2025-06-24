//
//  Untitled.swift
//  ReportViewer
//
//  Created by admin on 23/06/25.
//

import UserNotifications

class NotificationService {
    
    static func requestPermission(completion: @escaping (Bool) -> Void = {_ in }) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
            completion(granted)
        }
    }
    
    static func schedule(title: String, message: String) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            guard settings.authorizationStatus == .authorized else {
                print("Notifications not authorized")
                return
            }

            let content = UNMutableNotificationContent()
            content.title = title
            content.body = message
            content.sound = .default

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

            let request = UNNotificationRequest(
                identifier: UUID().uuidString,
                content: content,
                trigger: trigger
            )

            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Failed to schedule notification: \(error)")
                } else {
                    print("Notification scheduled: \(title)")
                }
            }
        }
    }

}

