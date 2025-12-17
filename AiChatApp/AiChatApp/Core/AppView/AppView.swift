//
//  AppView.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 2/10/25.
//

import SwiftUI

struct AppView: View {

    @Environment(AuthManager.self) private var authManager
    @Environment(UserManager.self) private var userManager
    @State var appState: AppState = AppState()

    var body: some View {
        AppViewBuilder(
            showTabBar: appState.showTabBar,
            tabBarView: {
                TabBarView()
            },
            onboardingView: {
                WelcomeView()
            }
        )
        .environment(appState)
        .task {
            await checkUserStatus()
        }
        .onChange(of: appState.showTabBar) { _, newValue in
            if !newValue {
                Task {
                    await checkUserStatus()
                }
            }
        }
    }

    private func checkUserStatus() async {
        if let user = authManager.auth {
            print("User alredy auth \(user.uid)")

            do {
                try await userManager.logIn(auth: user, isNewUser: false)
            } catch {
                print("Faild to log in to auth for existing user: \(error)")
                try? await Task.sleep(for: .seconds(5))
                await checkUserStatus()
            }
        } else {
            do {
                let result = try await authManager.signInAnnonymously()

                print("signInAnnonymously: \(result.user.uid)")

                try await userManager.logIn(auth: result.user, isNewUser: result.isNewUser)
            } catch {
                print("Faild to sign in anonymusly and log in: \(error)")
                try? await Task.sleep(for: .seconds(5))
                await checkUserStatus()
            }
        }
    }
}

#Preview("AppView - Tabbar") {
    AppView(appState: AppState(showTabBar: true))
        .environment(AuthManager(service: MockAuthService(user: .mock())))
        .environment(UserManager(service: MockUserService(user: .mock)))
}

#Preview("AppView - Onboarding") {
    AppView(appState: AppState(showTabBar: false))
        .environment(AuthManager(service: MockAuthService(user: nil)))
        .environment(UserManager(service: MockUserService(user: nil)))
}
