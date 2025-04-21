//
//  SettingsView.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 4/21/25.
//

import SwiftUI

struct SettingsView: View {

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
        appState.updateViewState(showTabBarView: false)
    }
}

#Preview {
    SettingsView()
        .environment(AppState())
}
