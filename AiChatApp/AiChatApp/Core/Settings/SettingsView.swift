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

    @State private var isPremium: Bool = false
    @State private var isAnonymousUser: Bool = false
    @State private var showCreateAccountView: Bool = false

    var body: some View {
        NavigationStack {
            List {
                accountSection
                purchasesSection
                aplicationSection
            }
            .navigationTitle("Settings")
            .sheet(isPresented: $showCreateAccountView) {
                CreateAccountView()
                    .presentationDetents([.medium])
            }
        }
    }

    var accountSection: some View {
        Section {
            if isAnonymousUser {
                Text("Save & back-up account")
                    .rowFormating()
                    .anyButton(.highlight) {
                        onCreateAccountPressed()
                    }
                    .removeListRowFormating()
            } else {
                Text("Sign out")
                    .rowFormating()
                    .anyButton(.highlight) {
                        onSignOutPressed()
                    }
                    .removeListRowFormating()
            }

            Text("Delete account")
                .foregroundStyle(.red)
                .rowFormating()
                .anyButton(.highlight) {
                }
                .removeListRowFormating()
        } header: {
            Text("Account")
        }
    }

    var purchasesSection: some View {
        Section {
            HStack(spacing: 8) {
                Text("Account status: \(isPremium ? "PMEMIUM" : "FREE")")
                Spacer(minLength: 0)
                if isPremium {
                    Text("MANAGE")
                        .badgeButton()
                }
            }
            .rowFormating()
            .anyButton(.highlight) {
            }
            .disabled(!isPremium)
            .removeListRowFormating()
        } header: {
            Text("Purchases")
        }
    }

    var aplicationSection: some View {
        Section {
            HStack {
                Text("Version")
                Spacer(minLength: 0)
                Text(Utilities.appVersion ?? "")
                    .foregroundStyle(.secondary)
            }
            .rowFormating()
            .removeListRowFormating()

            HStack {
                Text("Build Number")
                Spacer(minLength: 0)
                Text(Utilities.buildNumber ?? "")
                    .foregroundStyle(.secondary)
            }
            .rowFormating()
            .removeListRowFormating()

            Text("Contact us")
                .foregroundStyle(.blue)
                .rowFormating()
                .anyButton(.highlight) {
                }
                .removeListRowFormating()
        } header: {
            Text("Application")
        } footer: {
            VStack(alignment: .leading, spacing: 6) {
                Text("Created by YI.")
                Text("Learn more at www.swiftful-thinking.com")
            }
            .baselineOffset(6)
        }
    }

    func onSignOutPressed() {
        dismiss()

        Task {
            try? await Task.sleep(for: .seconds(1))
            appState.updateViewState(showTabBarView: false)
        }
    }

    func onCreateAccountPressed() {
        showCreateAccountView = true
    }
}

fileprivate extension View {
    func rowFormating() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(Color(.systemBackground))
    }
}

#Preview {
    SettingsView()
        .environment(AppState())
}
