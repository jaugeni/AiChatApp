//
//  MockUserPersistance.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 12/18/25.
//

struct MockUserPersistance: LocalUserPersistance {
    var currentUser: UserModel?

    init(user: UserModel? = nil) {
        currentUser = user
    }

    func getCurrentUser() -> UserModel? {
        currentUser
    }
    
    func saveCurrentUser(_ user: UserModel?) throws {
    }
}
