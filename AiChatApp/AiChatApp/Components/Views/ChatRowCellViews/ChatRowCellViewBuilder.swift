//
//  ChatRowCellViewBuilder.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 4/25/25.
//

import SwiftUI

struct ChatRowCellViewBuilder: View {

    var currentUserId: String? = ""
    var chat: ChatModel = .mock
    var getAvatar: () async -> AvatarModel?
    var getLastChatMessage: () async -> ChatMessageModel?

    @State private var avater: AvatarModel?
    @State private var lastChatMessage: ChatMessageModel?

    @State private var didLoadAvatar: Bool = false
    @State private var didLoadChatMessage: Bool = false

    private var isLoading: Bool {
        !(didLoadAvatar && didLoadChatMessage)
    }

    private var hasNewChat: Bool {
        guard let lastChatMessage, let currentUserId else { return false }
        return lastChatMessage.hasBeenSeenByCurrentUser(userId: currentUserId)
    }

    private var subheadline: String? {
        if isLoading {
           return "xxx xxx xxx xxx"
        }
        if avater == nil && lastChatMessage == nil {
            return "Error"
        }

        return lastChatMessage?.content
    }

    var body: some View {
        ChatRowCellView(
            imageName: avater?.profileImageName,
            headline: isLoading ? "xxx xxx" : avater?.name,
            subheadline: subheadline,
            hasNewChat: isLoading ? false : hasNewChat
        )
        .redacted(reason: isLoading ? .placeholder : [])
        .task {
            avater = await getAvatar()
            didLoadAvatar = true
        }
        .task {
            lastChatMessage = await getLastChatMessage()
            didLoadChatMessage = true
        }
    }
}

#Preview {
    VStack {
        ChatRowCellViewBuilder(
            chat: .mock,
            getAvatar: {
                try? await Task.sleep(for: .seconds(5))
                return .mock
            },
            getLastChatMessage: {
                try? await Task.sleep(for: .seconds(5))
                return .mock
            }
        )

        ChatRowCellViewBuilder(
            chat: .mock,
            getAvatar: { .mock },
            getLastChatMessage: { .mock }
        )

        ChatRowCellViewBuilder(
            chat: .mock,
            getAvatar: { nil },
            getLastChatMessage: { nil }
        )
    }
}
