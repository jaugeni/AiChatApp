//
//  MockAIService.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 12/19/25.
//

import SwiftUI

struct MockAIService: AIService {
    func generateImage(input: String) async throws -> UIImage {
        try? await Task.sleep(for: .seconds(3))
        return UIImage(systemName: "star.fill")!
    }
}
