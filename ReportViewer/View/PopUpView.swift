//
//  PopUpView.swift
//  ReportViewer
//
//  Created by admin on 23/06/25.
//

import SwiftUI

struct PopupView<Content: View>: View {
    let title: String
    let content: Content
    let onCancel: () -> Void
    let onConfirm: (() -> Void)?
    let confirmTitle: String

    init(
        title: String,
        confirmTitle: String = "Save",
        onCancel: @escaping () -> Void,
        onConfirm: (() -> Void)? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.content = content()
        self.onCancel = onCancel
        self.onConfirm = onConfirm
        self.confirmTitle = confirmTitle
    }

    var body: some View {
        VStack(spacing: 16) {
            Text(title)
                .font(.headline)
                .padding(.top)

            content

            HStack {
                Button("Cancel", action: onCancel)
                    .foregroundColor(.red)

                Spacer()

                if let onConfirm = onConfirm {
                    Button(confirmTitle, action: onConfirm)
                        .foregroundColor(confirmTitle == "Delete" ? .red : .blue)
                }
            }
            .padding(.horizontal)
        }
        .padding()
        .frame(maxWidth: 300)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(radius: 10)
    }
}
