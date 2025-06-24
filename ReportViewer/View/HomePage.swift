//
//  HomePage.swift
//  ReportViewer
//
//  Created by admin on 23/06/25.
//

import SwiftUI

struct HomePage: View {
    @EnvironmentObject var authVM: AuthViewModel
    @StateObject var notificationVM = NotificationViewModel()

    let items: [(title: String, systemImage: String, destination: AnyView)] = [
        ("PDF Viewer", "doc.richtext", AnyView(PDFViewerView())),
        ("Image Capture", "camera", AnyView(ImageCaptureView())),
        ("Stored Items", "tray.full", AnyView(StoredItemsView())),
        ("Settings", "gear", AnyView(SettingsView()))
    ]

    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 24) {
                ForEach(0..<items.count, id: \.self) { index in
                    NavigationLink(destination: items[index].destination) {
                        VStack(spacing: 10) {
                            Image(systemName: items[index].systemImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.blue)

                            Text(items[index].title)
                                .font(.caption)
                                .foregroundColor(.primary)
                        }
                        .frame(maxWidth: .infinity, minHeight: 100)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .shadow(radius: 2)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Dashboard")
        .onAppear {
            notificationVM.requestPermission()
        }
    }
}

