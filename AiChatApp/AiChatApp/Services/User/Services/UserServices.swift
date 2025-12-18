//
//  UserServices.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 12/18/25.
//

protocol UserServices {
    var remote: RemoteUserService { get }
        var local: LocalUserPersistance { get }
}

struct MockUserServices: UserServices {
    let remote: RemoteUserService
    let local: LocalUserPersistance

    init(user: UserModel? = nil) {
        remote = MockUserService(user: user)
        local = MockUserPersistance(user: user)
    }
}

struct ProductionUserServices: UserServices {
    let remote: RemoteUserService = FirebaseUserService()
    let local: LocalUserPersistance = FileManagerUserPersistance()
}
