//
//  SettingsView.swift
//  ReportViewer
//
//  Created by admin on 23/06/25.
//

import SwiftUI
import FirebaseAuth

struct SettingsView: View {
    @StateObject var notificationVM = NotificationViewModel()
    @EnvironmentObject var authVM: AuthViewModel
    @Environment(\.dismiss) var dismiss

    @State private var showLogoutConfirmation = false
    @State private var shouldDismiss = false

    var body: some View {
        VStack(spacing: 20) {
            VStack {
                Toggle("Enable Notifications", isOn: $notificationVM.isEnabled)
                    .padding()
                    .onAppear {
                        notificationVM.requestPermission()
                    }
            }
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .padding(.horizontal)
            
            Spacer()
        }
        .navigationTitle("Settings")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showLogoutConfirmation = true
                }) {
                    Text("Logout")
                        .foregroundColor(.red)
                }
            }
        }
        .confirmationDialog(
            "Are you sure you want to log out?",
            isPresented: $showLogoutConfirmation,
            titleVisibility: .visible
        ) {
            Button("Log Out", role: .destructive) {
                authVM.signOut()
                shouldDismiss = true
            }
            Button("Cancel", role: .cancel) {}
        }
        .onChange(of: authVM.user) { newValue in
            if newValue == nil && shouldDismiss {
                dismiss()
            }
        }
    }
}
