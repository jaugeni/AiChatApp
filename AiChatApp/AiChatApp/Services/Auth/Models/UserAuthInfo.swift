//
//  UserAuthInfo.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 12/16/25.
//

import SwiftUI

struct UserAuthInfo: Sendable {
    let uid: String
    let email: String?
    let isAnonymous: Bool
    let creationDate: Date?
    let lastSignInDate: Date?

    init(
        uid: String,
        email: String? = nil,
        isAnonymous: Bool = false,
        creationDate: Date? = nil,
        lastSignInDate: Date? = nil
    ) {
        self.uid = uid
        self.email = email
        self.isAnonymous = isAnonymous
        self.creationDate = creationDate
        self.lastSignInDate = lastSignInDate
    }

    static func mock(isAnonymus: Bool = false) -> Self {
        UserAuthInfo(
            uid: "mock_user_123",
            email: "hello@gmail.com",
            isAnonymous: isAnonymus,
            creationDate: .now,
            lastSignInDate: .now
        )
    }
}
