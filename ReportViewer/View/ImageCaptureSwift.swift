//
//  ImageCaptureSwift.swift
//  ReportViewer
//
//  Created by admin on 20/06/25.
//

import SwiftUI

struct ImageCaptureView: View {
    @StateObject var pickerVM = ImagePickerViewModel()
    @State private var showPicker = false
    @State private var selectedSource: UIImagePickerController.SourceType = .photoLibrary

    var body: some View {
        VStack(spacing: 30) {
            if let image = pickerVM.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                    .cornerRadius(12)
                    .shadow(radius: 5)
            } else {
                Text("No Image Selected")
            }

            HStack(spacing: 20) {
                Button(action: {
                    if UIImagePickerController.isSourceTypeAvailable(.camera) {
                         selectedSource = .camera
                         showPicker = true
                     } else {
                         print("Camera not available")
                     }
                }) {
                    HStack {
                        Image(systemName: "camera")
                        Text("Camera")
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }

                Button(action: {
                    selectedSource = .photoLibrary
                    showPicker = true
                }) {
                    HStack {
                        Image(systemName: "photo.on.rectangle")
                        Text("Gallery")
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Image Capture")
        .sheet(isPresented: $showPicker) {
            ImagePicker(image: $pickerVM.image, sourceType: selectedSource)
        }
    }
}
