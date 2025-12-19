//
//  AIManager.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 12/19/25.
//

import SwiftUI

protocol AIService: Sendable {
    func generateImage(input: String) async throws -> UIImage
}

struct MockAIService: AIService {
    func generateImage(input: String) async throws -> UIImage {
        try? await Task.sleep(for: .seconds(3))
        return UIImage(systemName: "star.fill")!
    }
}

import OpenAI
struct OpenAIServer: AIService {

    var openAI: OpenAI {
        OpenAI(apiToken: Secrets.aiKey)
    }

    func generateImage(input: String) async throws -> UIImage {
        let query = ImagesQuery(
            prompt: input,
//            model: .gpt4,
            n: 1,
            responseFormat: .b64_json,
            size: ._512,
            user: nil
        )

        let result = try await openAI.images(query: query)

        guard let b64Json = result.data.first?.b64Json,
              let data = Data(base64URLEncoded: b64Json),
              let image = UIImage(data: data) else {
            throw OpenAiError.invalidResponse
        }

        return image
    }

    enum OpenAiError: LocalizedError {
        case invalidResponse
    }
}

@MainActor
@Observable
class AiManager {

    private let service: AIService

    init(service: AIService) {
        self.service = service
    }

    func generateImage(input: String) async throws -> UIImage {
        try await service.generateImage(input: input)
    }

}
