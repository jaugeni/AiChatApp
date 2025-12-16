//
//  MockAuthService.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 12/16/25.
//

import Foundation

struct MockAuthService: AuthService {

    let currentUser: UserAuthInfo?

    init(user: UserAuthInfo? = nil) {
        currentUser = user
    }

    func addAuthenticatedUserListener(onListenerAttachd: (any NSObjectProtocol) -> Void) -> AsyncStream<UserAuthInfo?> {
        AsyncStream { continuation in
            continuation.yield(currentUser)
        }
    }

    func getAuthenticatedUser() -> UserAuthInfo? {
        currentUser
    }
    
    func signInAnnonymously() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        let user = UserAuthInfo.mock(isAnonymus: true)
        return (user, true)
    }
    
    func signInApple() async throws -> (user: UserAuthInfo, isNewUser: Bool) {
        let user = UserAuthInfo.mock(isAnonymus: false)
        return (user, false)
    }
    
    func signOut() throws {

    }
    
    func deleteAccount() async throws {
        
    }

}
