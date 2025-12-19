//
//  AIService.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 12/19/25.
//

import SwiftUI

protocol AIService: Sendable {
    func generateImage(input: String) async throws -> UIImage
}
