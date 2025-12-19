//
//  AiChatAppApp.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 2/10/25.
//

import SwiftUI
import Firebase

@main
struct AiChatAppApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            AppView()
                .environment(delegate.dependencies.aiManager)
                .environment(delegate.dependencies.avatarManager)
                .environment(delegate.dependencies.usermanager)
                .environment(delegate.dependencies.authManager)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    var dependencies: Dependencies!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()

        dependencies = Dependencies()

        return true
    }
}

@MainActor
struct Dependencies {
    let authManager: AuthManager
    let usermanager: UserManager
    let aiManager: AiManager
    let avatarManager: AvatarManager

    init() {
        authManager = AuthManager(service: FirebaseAuthService())
        usermanager = UserManager(services: ProductionUserServices())
        aiManager = AiManager(service: OpenAIServer())
        avatarManager = AvatarManager(service: FirebaseAvatarService())
    }
}
