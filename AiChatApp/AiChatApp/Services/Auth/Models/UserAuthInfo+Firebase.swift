//
//  UserAuthInfo+Firebase.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 12/16/25.
//

import FirebaseAuth

extension UserAuthInfo {
    init(from user: User) {
        uid = user.uid
        email = user.email
        isAnonymous = user.isAnonymous
        creationDate = user.metadata.creationDate
        lastSignInDate = user.metadata.lastSignInDate
    }
}
