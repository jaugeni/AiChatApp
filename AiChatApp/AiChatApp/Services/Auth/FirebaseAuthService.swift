//
//  FirebaseAuthService.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 12/16/25.
//

import FirebaseAuth
import SwiftUI

extension EnvironmentValues {
    @Entry var authService: FirebaseAuthService = FirebaseAuthService()
}

struct UserAuthInfo: Sendable {
    let uid: String
    let email: String?
    let isAnonymous: Bool
    let creationDate: Date?
    let lastSignInDate: Date?

    init(
        uid: String,
        email: String? = nil,
        isAnonymous: Bool = false,
        creationDate: Date? = nil,
        lastSignInDate: Date? = nil
    ) {
        self.uid = uid
        self.email = email
        self.isAnonymous = isAnonymous
        self.creationDate = creationDate
        self.lastSignInDate = lastSignInDate
    }

    init(from user: User) {
        uid = user.uid
        email = user.email
        isAnonymous = user.isAnonymous
        creationDate = user.metadata.creationDate
        lastSignInDate = user.metadata.lastSignInDate
    }
}

struct FirebaseAuthService {

    func getAuthenticatedUser() -> UserAuthInfo? {
        if let user = Auth.auth().currentUser {
            return UserAuthInfo(from: user)
        }
        return nil
    }

    func signInAnnonymously() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        let result = try await Auth.auth().signInAnonymously()
        let user = UserAuthInfo(from: result.user)
        let isNewUser = result.additionalUserInfo?.isNewUser ?? true
        return (user, isNewUser)
    }
}
