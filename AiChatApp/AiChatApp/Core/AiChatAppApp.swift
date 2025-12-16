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
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()

        return true
    }
}
