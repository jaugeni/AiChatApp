//
//  SettingsView.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 4/21/25.
//

import SwiftUI

struct SettingsView: View {

    @Environment(\.dismiss) var dismiss
    @Environment(AuthManager.self) private var authManager
    @Environment(UserManager.self) private var userManager
    @Environment(AppState.self) private var appState

    @State private var isPremium: Bool = false
    @State private var isAnonymousUser: Bool = false
    @State private var showCreateAccountView: Bool = false
    @State private var showAlert: AnyAppAlert?

    var body: some View {
        NavigationStack {
            List {
                accountSection
                purchasesSection
                aplicationSection
            }
            .navigationTitle("Settings")
            .sheet(
                isPresented: $showCreateAccountView,
                onDismiss: {
                    setAnonymousAccountStatus()
                },
                content: {
                    CreateAccountView()
                        .presentationDetents([.medium])
                }
            )
            .onAppear {
                setAnonymousAccountStatus()
            }
            .showCustomAlert(alert: $showAlert)
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
                    onDeleteAccountTap()
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

    func setAnonymousAccountStatus() {
        isAnonymousUser = authManager.auth?.isAnonymous == true
    }

    func onSignOutPressed() {
        Task {
            do {
                try authManager.signOut()
                userManager.signOut()

                await dismissScreen()
            } catch {
                showAlert = AnyAppAlert(error: error)
            }
        }
    }

    private func dismissScreen() async {
        dismiss()
        try? await Task.sleep(for: .seconds(1))
        appState.updateViewState(showTabBarView: false)
    }

    func onDeleteAccountTap() {
        showAlert = AnyAppAlert(
            title: "Delete Account?",
            subtitle: "This action is permanent and cannot be undone. Your data will be deleted from our server forever.",
            buttons: {
                AnyView(
                    Button("Delete", role: .destructive) {
                        onDeleteAccountConfirmd()
                    }
                )
            }
        )
    }

    private func onDeleteAccountConfirmd() {
        Task {
            do {
                try await authManager.deleteAccount()
                try await userManager.deleteCurrentUser()

                await dismissScreen()
            } catch {
                showAlert = AnyAppAlert(error: error)
            }
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

#Preview("No auth") {
    SettingsView()
        .environment(AuthManager(service: MockAuthService(user: nil)))
        .environment(UserManager(services: MockUserServices(user: nil)))
        .environment(AppState())
}

#Preview("Annonymous") {
    SettingsView()
        .environment(AuthManager(service: MockAuthService(user: UserAuthInfo.mock(isAnonymus: true))))
        .environment(UserManager(services: MockUserServices(user: .mock)))
        .environment(AppState())
}

#Preview("Not annonymous") {
    SettingsView()
        .environment(AuthManager(service: MockAuthService(user: UserAuthInfo.mock())))
        .environment(UserManager(services: MockUserServices(user: .mock)))
        .environment(AppState())
}
