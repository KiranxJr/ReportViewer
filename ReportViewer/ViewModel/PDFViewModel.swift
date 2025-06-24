//
//  Untitled.swift
//  ReportViewer
//
//  Created by admin on 23/06/25.
//

import Foundation

class PDFViewModel: ObservableObject {
    @Published var url: URL = URL(string: "https://fssservices.bookxpert.co/GeneratedPDF/Companies/nadc/2024-2025/BalanceSheet.pdf")!
}
