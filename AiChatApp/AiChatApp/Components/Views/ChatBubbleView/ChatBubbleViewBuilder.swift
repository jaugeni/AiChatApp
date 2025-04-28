//
//  ChatBubbleViewBuilder.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 4/28/25.
//

import SwiftUI

struct ChatBubbleViewBuilder: View {

    var message: ChatMessageModel = .mock
    var isCurretUser: Bool = false
    var imageName: String?

    var body: some View {
        ChatBubbleView(
            text: message.content ?? "",
            textColor: isCurretUser ? .white : .primary,
            backgroundColor: isCurretUser ? .accent : Color(.systemGray6),
            showImage: !isCurretUser,
            imageName: imageName
        )
        .frame(maxWidth: .infinity, alignment: isCurretUser ? .trailing : .leading)
        .padding(.leading, isCurretUser ? 75 : 0)
        .padding(.trailing, isCurretUser ? 0 : 75)

    }
}

#Preview {
    ScrollView {
        VStack(spacing: 24) {
            ChatBubbleViewBuilder()
            ChatBubbleViewBuilder(isCurretUser: true)
            ChatBubbleViewBuilder(
                message: ChatMessageModel(
                    id: UUID().uuidString,
                    chatId: UUID().uuidString,
                    authorId: UUID().uuidString,
                    content: "This is some longer content that goes on to multiple lines and keeps on going to another line!|",
                    seenByIds: nil,
                    dateCreated: .now
                )
            )
            ChatBubbleViewBuilder(
                message: ChatMessageModel(
                    id: UUID().uuidString,
                    chatId: UUID().uuidString,
                    authorId: UUID().uuidString,
                    content: "This is some longer content that goes on to multiple lines and keeps on going to another line!|",
                    seenByIds: nil,
                    dateCreated: .now
                ),
                isCurretUser: true
            )

        }
        .padding()
    }
}
