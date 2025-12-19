//
//  AIManager.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 12/19/25.
//

import SwiftUI







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
