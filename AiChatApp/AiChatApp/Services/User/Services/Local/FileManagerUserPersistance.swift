//
//  FileManagerUserPersistance.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 12/18/25.
//

import Foundation

struct FileManagerUserPersistance: LocalUserPersistance {
    private let userDocumentKey = "current_user"

    func getCurrentUser() -> UserModel? {
        try? FileManager.getDocument(key: userDocumentKey)
    }

    func saveCurrentUser(_ user: UserModel?) throws {
        try FileManager.saveDocument(key: userDocumentKey, value: user)
    }
}
