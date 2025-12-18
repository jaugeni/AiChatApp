//
//  Untitled.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 12/18/25.
//

import Foundation

extension FileManager {

    static func saveDocument<T: Codable>(key: String, value: T?) throws {
        let url = getDocumentURL(for: key)
        let data = try JSONEncoder().encode(value)
        try data.write(to: url)
    }

    static func getDocument<T: Codable>(key: String) throws -> T {
        let url = getDocumentURL(for: key)
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(T.self, from: data)
    }

    private static func getDocumentURL( for key: String) -> URL {
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first!
            .appendingPathExtension("txt")
    }
}
