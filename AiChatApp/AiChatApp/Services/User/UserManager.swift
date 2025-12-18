//
//  UserManager.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 12/17/25.
//

import SwiftUI

@MainActor
@Observable
class UserManager {

    private let remote: RemoteUserService
    private let local: LocalUserPersistance
    private(set) var currentUser: UserModel?
    private var task: Task<Void, Never>?

    init(services: UserServices) {
        self.remote = services.remote
        self.local = services.local
        self.currentUser = local.getCurrentUser()
    }

    func logIn(auth: UserAuthInfo, isNewUser: Bool) async throws {
        let creationVersion = isNewUser ? Utilities.appVersion : nil
        let user = UserModel(auth: auth, creationVersion: creationVersion)
        try await remote.saveUser(user: user)
        addCurrentUserListener(userId: auth.uid)
    }

    private func addCurrentUserListener(userId: String) {
        task?.cancel()

        task = Task {
            do {
                let stream = remote.streamUser(userId: userId)

                for try await value in stream {
                    self.currentUser = value
                    self.saveCurrentUserLocally()
                    print("Successfully attached user listener \(value.userId)")
                }
            } catch {
                print("Error attaching user listener: \(error)")
            }
        }
    }

    private func saveCurrentUserLocally() {
        Task {
            do {
                try local.saveCurrentUser(currentUser)
                print("Success saving current user locally")
            } catch {
                print("Error saving current user locally: \(error)")
            }
        }
    }

    func markOnboardingCompleatForCurrentUser(profileColorHex: String) async throws {
        let uid = try currentUserId()
        try await remote.markOnboardingCompleated(userId: uid, profileColorHex: profileColorHex)
    }

    func signOut() {
        task?.cancel()
        task = nil
        currentUser = nil
    }

    func deleteCurrentUser() async throws {
        let uid = try currentUserId()
        try await remote.deleteUser(userId: uid)
        signOut()
    }

    private func currentUserId() throws -> String {
        guard let uid = currentUser?.userId else {
            throw UserManagerError.noUserId
        }
        return uid
    }

    enum UserManagerError: LocalizedError {
        case noUserId
    }
}
