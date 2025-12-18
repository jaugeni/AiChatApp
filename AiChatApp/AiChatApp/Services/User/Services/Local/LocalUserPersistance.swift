//
//  LocalUserPersistance.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 12/18/25.
//

protocol LocalUserPersistance: Sendable {
    func getCurrentUser() -> UserModel?
    func saveCurrentUser(_ user: UserModel?) throws
}
