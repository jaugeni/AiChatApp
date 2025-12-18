//
//  Secrets.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 12/18/25.
//

import Foundation

enum Secrets {
    static func value(for key: String) -> String {
        guard let value = Bundle.main.object(
            forInfoDictionaryKey: key
        ) as? String else {
            fatalError("Missing secret: \(key)")
        }
        return value
    }

    static let aiKey = value(for: "AI_KEY")
}
