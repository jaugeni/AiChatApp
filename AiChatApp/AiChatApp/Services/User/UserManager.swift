//
//  UserManager.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 12/17/25.
//

import SwiftUI

protocol UserService: Sendable {
    func saveUser(user: UserModel) async throws
    func streamUser(userId: String) -> AsyncThrowingStream<UserModel, Error>
    func deleteUser(userId: String) async throws
    func markOnboardingCompleated(userId: String, profileColorHex: String) async throws
}

struct MockUserService: UserService {

    let currentUser: UserModel?

    init(user: UserModel? = nil) {
        currentUser = user
    }

    func saveUser(user: UserModel) async throws {

    }
    
    func streamUser(userId: String) -> AsyncThrowingStream<UserModel, any Error> {
        AsyncThrowingStream { continuation in
            if let currentUser {
                continuation.yield(currentUser)
            }
        }
    }
    
    func deleteUser(userId: String) async throws {

    }
    
    func markOnboardingCompleated(userId: String, profileColorHex: String) async throws {

    }
    

}

import FirebaseFirestore
import SwiftfulFirestore

struct FirebaseUserService: UserService {

    var collection: CollectionReference {
        Firestore.firestore().collection("users")
    }

    func saveUser(user: UserModel) async throws {
        try collection.document(user.userId).setData(from: user, merge: true)
    }

    func markOnboardingCompleated(userId: String, profileColorHex: String) async throws {
        try await collection.document(userId).updateData([
            UserModel.CodingKeys.didCompleteOnboarding.rawValue: true,
            UserModel.CodingKeys.profileColorHex.rawValue: profileColorHex
        ])
    }

    func streamUser(userId: String) -> AsyncThrowingStream<UserModel, Error> {
        collection.streamDocument(id: userId)
    }

    func deleteUser(userId: String) async throws {
        try await collection.document(userId).delete()
    }
}

@MainActor
@Observable
class UserManager {

    private let service: UserService
    private(set) var currentUser: UserModel?
    private var task: Task<Void, Never>?

    init(service: UserService) {
        self.service = service
        self.currentUser = nil
    }

    func logIn(auth: UserAuthInfo, isNewUser: Bool) async throws {
        let creationVersion = isNewUser ? Utilities.appVersion : nil
        let user = UserModel(auth: auth, creationVersion: creationVersion)
        try await service.saveUser(user: user)
        addCurrentUserListener(userId: auth.uid)
    }

    private func addCurrentUserListener(userId: String) {
        task?.cancel()

        task = Task {
            do {
                let stream = service.streamUser(userId: userId)

                for try await value in stream {
                    self.currentUser = value
                    print("Successfully attached user listener \(value.userId)")
                }
            } catch {
                print("Error attaching user listener: \(error)")
            }
        }
    }

    func markOnboardingCompleatForCurrentUser(profileColorHex: String) async throws {
        let uid = try currentUserId()
        try await service.markOnboardingCompleated(userId: uid, profileColorHex: profileColorHex)
    }

    func signOut() {
        task?.cancel()
        task = nil
        currentUser = nil
    }

    func deleteCurrentUser() async throws {
        let uid = try currentUserId()
        try await service.deleteUser(userId: uid)
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
