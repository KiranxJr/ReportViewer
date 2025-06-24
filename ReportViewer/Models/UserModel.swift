//
//  UserModel.swift
//  ReportViewer
//
//  Created by admin on 23/06/25.
//

import Foundation

struct UserModel: Identifiable {
    let id = UUID()
    let name: String
    let email: String
}


