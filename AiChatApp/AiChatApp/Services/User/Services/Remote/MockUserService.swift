//
//  MockUserService.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 12/18/25.
//

struct MockUserService: RemoteUserService {

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
