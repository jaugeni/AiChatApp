//
//  SettingsView.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 4/21/25.
//

import SwiftUI

struct SettingsView: View {

    @Environment(\.dismiss) var dismiss
    @Environment(AppState.self) private var appState

    var body: some View {
        NavigationStack {
            List {
                Button {
                    onSignOutPressed()
                } label: {
                    Text("Sign out")
                }
            }
            .navigationTitle("Settings")
        }
    }

    func onSignOutPressed() {
        dismiss()

        Task {
            try? await Task.sleep(for: .seconds(1))
            appState.updateViewState(showTabBarView: false)
        }
    }
}

#Preview {
    SettingsView()
        .environment(AppState())
}
