//
//  ContentView.swift
//  ReportViewer
//
//  Created by admin on 20/06/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        Group {
            if authVM.user != nil {
                HomePage()
            } else {
                LoginView()
            }
        }
        .animation(.easeInOut, value: authVM.user != nil)
    }
}


#Preview {
    ContentView()
}
