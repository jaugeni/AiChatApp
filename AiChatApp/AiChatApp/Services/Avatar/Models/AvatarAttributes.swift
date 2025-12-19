//
//  AvatarAttributes.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 4/28/25.
//

import Foundation

enum CharacterOption: String, CaseIterable, Hashable, Codable {
    case male,
         female,
         alien,
         dog,
         cat

    static var `default`: Self {
        .male
    }

    var plural: String {
        switch self {
        default:
            self.rawValue + "s"
        }
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

enum CharacterAction: String, CaseIterable, Hashable, Codable {
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

enum CharacterLocation: String, CaseIterable, Hashable, Codable {
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
