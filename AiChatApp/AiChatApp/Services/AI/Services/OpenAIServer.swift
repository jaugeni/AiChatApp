//
//  OpenAIServer.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 12/19/25.
//

import SwiftUI
import OpenAI

struct OpenAIServer: AIService {

    var openAI: OpenAI {
        OpenAI(apiToken: Secrets.aiKey)
    }

    func generateImage(input: String) async throws -> UIImage {
        let query = ImagesQuery(
            prompt: input,
            model: .gpt_image_1,
            n: 1,
            responseFormat: .b64_json,
            size: ._256,
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
