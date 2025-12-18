//
//  RemoteUserService.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 12/18/25.
//

protocol RemoteUserService: Sendable {
    func saveUser(user: UserModel) async throws
    func streamUser(userId: String) -> AsyncThrowingStream<UserModel, Error>
    func deleteUser(userId: String) async throws
    func markOnboardingCompleated(userId: String, profileColorHex: String) async throws
}
