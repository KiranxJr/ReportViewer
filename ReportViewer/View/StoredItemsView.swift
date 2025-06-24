//
//  StoredItemsView.swift
//  ReportViewer
//
//  Created by admin on 23/06/25.
//

import SwiftUI

struct StoredItemsView: View {
    @EnvironmentObject var viewModel: CoreDataViewModel

    @State private var selectedItem: ItemEntity?
    @State private var newName: String = ""
    @State private var showEditPopup: Bool = false
    @State private var showDeletePopup: Bool = false

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        viewModel.fetchFromAPIAndStore()
                    }) {
                        Image(systemName: "arrow.down.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.blue)
                            .padding()
                    }
                }

                List {
                    ForEach(viewModel.items, id: \.objectID) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name ?? "Unnamed")
                                    .font(.body)
                            }

                            Spacer()

                            Button(action: {
                                selectedItem = item
                                newName = item.name ?? ""
                                showEditPopup = true
                            }) {
                                Image(systemName: "pencil")
                                    .foregroundColor(.blue)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding(.horizontal, 4)

                            Button(action: {
                                selectedItem = item
                                showDeletePopup = true
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding(.horizontal, 4)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }

            // Background overlay
            if showEditPopup || showDeletePopup {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
            }

            // MARK: - Edit Popup
            if showEditPopup {
                PopupView(
                    title: "Edit Item Name",
                    onCancel: {
                        showEditPopup = false
                    },
                    onConfirm: {
                        if let item = selectedItem, !newName.trimmingCharacters(in: .whitespaces).isEmpty {
                            viewModel.updateItem(item, newName: newName)
                        }
                        showEditPopup = false
                    }
                ) {
                    TextField("New Name", text: $newName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                }
            }

            // MARK: - Delete Popup
            if showDeletePopup {
                PopupView(
                    title: "Confirm Delete",
                    confirmTitle: "Delete",
                    onCancel: {
                        showDeletePopup = false
                    },
                    onConfirm: {
                        if let item = selectedItem {
                            viewModel.deleteItem(item)
                        }
                        showDeletePopup = false
                    }
                ) {
                    Text("Are you sure you want to delete this item?")
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

            }
        }
        .navigationTitle("Stored Items")
    }
}
