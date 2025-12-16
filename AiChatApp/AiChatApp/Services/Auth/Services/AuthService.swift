//
//  AuthService.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 12/16/25.
//

import SwiftUI

protocol AuthService: Sendable {
    func addAuthenticatedUserListener(onListenerAttachd: (any NSObjectProtocol) -> Void) -> AsyncStream<UserAuthInfo?>
    func getAuthenticatedUser() -> UserAuthInfo?
    func signInAnnonymously() async throws -> (user: UserAuthInfo, isNewUser: Bool)
    func signInApple() async throws -> (user: UserAuthInfo, isNewUser: Bool)
    func signOut() throws
    func deleteAccount() async throws
}
