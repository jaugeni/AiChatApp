//
//  TextValidationHelper.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 4/29/25.
//

import Foundation

struct TextValidationHelper {
    enum TextValidationError: LocalizedError {
        case notEnoughtCharacters(min: Int)
        case hasBadWords

        var errorDescription: String? {
            switch self {
            case .notEnoughtCharacters(min: let min):
                return "Please add at least \(min) characters."
            case .hasBadWords:
                return "Bad word detected. Please rephrase your message."
            }
        }
    }

    static func checkIfTextIsValid(text: String) throws {
        let minimunCCharacterCount = 4

        guard text.count >= minimunCCharacterCount else {
            throw TextValidationError.notEnoughtCharacters(min: minimunCCharacterCount)
        }

        let badWords: [String] = [
            "shit", "bitch", "ass"
        ]

        if badWords.contains(text.lowercased()) {
            throw TextValidationError.hasBadWords
        }
    }
}
