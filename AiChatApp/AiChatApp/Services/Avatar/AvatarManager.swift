//
//  AvatarManager.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 12/19/25.
//

import SwiftUI

protocol AvatarService: Sendable {
    func createAvatar(avatar: AvatarModel, image: UIImage) async throws
}

struct MockAvatarService: AvatarService {
    func createAvatar(avatar: AvatarModel, image: UIImage) async throws {

    }
}

import SwiftfulFirestore
import FirebaseFirestore

struct FirebaseAvatarService: AvatarService {

    var collection: CollectionReference {
        Firestore.firestore().collection("avatars")
    }

    func createAvatar(avatar: AvatarModel, image: UIImage) async throws {
        let path = "avatars/\(avatar.avatarId)"
        let url = try await FirebaseImageUploadService().uploadImage(image: image, path: path)

        var avatar = avatar
        avatar.updateProfileImage(imageName: url.absoluteString)

        try collection.document(avatar.avatarId).setData(from: avatar, merge: true)
    }
}

@MainActor
@Observable
class AvatarManager {

    private let service: AvatarService

    init(service: AvatarService) {
        self.service = service
    }

    func createAvatar(avatar: AvatarModel, image: UIImage) async throws {
        try await service.createAvatar(avatar: avatar, image: image)
    }
}
