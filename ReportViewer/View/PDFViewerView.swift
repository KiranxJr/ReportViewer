//
//  PDFViewerView.swift
//  ReportViewer
//
//  Created by admin on 20/06/25.
//

import SwiftUI
import PDFKit

struct PDFViewerView: View {
    @EnvironmentObject var pdfVM: PDFViewModel
    var body: some View {
        PDFKitView(url: pdfVM.url)
            .navigationTitle("PDF Viewer")
    }
}

struct PDFKitView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: url)
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {}
}
