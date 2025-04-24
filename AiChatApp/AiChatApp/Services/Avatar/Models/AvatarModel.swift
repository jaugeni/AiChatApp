//
//  AvatarModel.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 4/22/25.
//

import Foundation

struct AvatarModel: Hashable {

    let avatarid: String
    let name: String?
    let characterOption: CharacterOption?
    let characterAction: CharacterAction?
    let characterLocation: CharacterLocation?
    let profileImageName: String?
    let authorId: String?
    let dateCreated: Date?

    init(
        avatarid: String,
        name: String? = nil,
        characterOption: CharacterOption? = nil,
        characterAction: CharacterAction? = nil,
        characterLocation: CharacterLocation? = nil,
        profileImageName: String? = nil,
        authorId: String? = nil,
        dateCreated: Date? = nil
    ) {
        self.avatarid = avatarid
        self.name = name
        self.characterOption =         characterOption
        self.characterAction = characterAction
        self.characterLocation = characterLocation
        self.profileImageName = profileImageName
        self.authorId = authorId
        self.dateCreated = dateCreated
    }

    var characterDescription: String {
        AvatarDescriptionBuilder(avatar: self).characterDescription
    }

    static var mock: AvatarModel {
        .mocks[0]
    }

    static var mocks: [AvatarModel] {
        [
            AvatarModel(avatarid: UUID().uuidString, name: "Alpha", characterOption: .alien, characterAction: .smiling, characterLocation: .park, profileImageName: Constants.randomImage, authorId: UUID().uuidString, dateCreated: .now),
            AvatarModel(avatarid: UUID().uuidString, name: "Beta", characterOption: .dog, characterAction: .eating, characterLocation: .forest, profileImageName: Constants.randomImage, authorId: UUID().uuidString, dateCreated: .now),
            AvatarModel(avatarid: UUID().uuidString, name: "Gamma", characterOption: .cat, characterAction: .drinking, characterLocation: .museum, profileImageName: Constants.randomImage, authorId: UUID().uuidString, dateCreated: .now),
            AvatarModel(avatarid: UUID().uuidString, name: "Delta", characterOption: .female, characterAction: .shopping, characterLocation: .park, profileImageName: Constants.randomImage, authorId: UUID().uuidString, dateCreated: .now)
        ]
    }
}

struct AvatarDescriptionBuilder {
    let characterOption: CharacterOption
    let characterAction: CharacterAction
    let characterLocation: CharacterLocation

    init(characterOption: CharacterOption, characterAction: CharacterAction, characterLocation: CharacterLocation) {
        self.characterOption = characterOption
        self.characterAction = characterAction
        self.characterLocation = characterLocation
    }

    init(avatar: AvatarModel) {
        self.characterOption = avatar.characterOption ?? .default
        self.characterAction = avatar.characterAction ?? .default
        self.characterLocation = avatar.characterLocation ?? .default
    }

    var characterDescription: String {
        let prefix =  characterOption.startsWithVowel ? "An" : "A"
        return "\(prefix) \(characterOption) that is \(characterAction) in the \(characterLocation)."
    }
}

enum CharacterOption: String, CaseIterable, Hashable {
    case male,
         female,
         alien,
         dog,
         cat

    static var `default`: Self {
        .male
    }

    var startsWithVowel: Bool {
        switch self {
        case .alien:
            return true
        default:
            return false
        }
    }
}

enum CharacterAction {
    case smiling,
         sitting,
         eating,
         drinking,
         walking,
         shopping,
         studying,
         working,
         relaxing,
         fiting,
         crying

    static var `default`: Self {
        .smiling
    }
}

enum CharacterLocation {
    case park,
         mall,
         museum,
         city,
         desert,
         forest,
         space

    static var `default`: Self {
        .park
    }
}
