//
//  ReportViewerApp.swift
//  ReportViewer
//
//  Created by admin on 20/06/25.
//

import SwiftUI
import Firebase


@main
struct ReportViewerApp: App {
    @StateObject var authVM = AuthViewModel()
    init() {
        FirebaseApp.configure()
        UNUserNotificationCenter.current().delegate = NotificationDelegate.shared
    }

    
        var body: some Scene {
            WindowGroup {
                NavigationStack {
                    ContentView()
                }
                .environmentObject(authVM)
                .environmentObject(CoreDataViewModel())
                .environmentObject(PDFViewModel())
            }
        }
    }
