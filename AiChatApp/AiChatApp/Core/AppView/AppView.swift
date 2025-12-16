//
//  AppView.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 2/10/25.
//

import SwiftUI

struct AppView: View {

    @Environment(\.authService) private var authService
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
    }

    private func checkUserStatus() async {
        if let user = authService.getAuthenticatedUser() {
            print("User alredy auth \(user.uid)")
        } else {
            do {
                let result = try await authService.signInAnnonymously()

                print("signInAnnonymously: \(result.user.uid)")
            } catch {
                print(error)
            }
        }
    }
}

#Preview("AppView - Tabbar") {
    AppView(appState: AppState(showTabBar: true))
}

#Preview("AppView - Onboarding") {
    AppView(appState: AppState(showTabBar: false))
}
