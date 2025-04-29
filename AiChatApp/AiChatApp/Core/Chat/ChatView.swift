//
//  ChatView.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 4/28/25.
//

import SwiftUI

struct ChatView: View {

    @State private var chatMessages: [ChatMessageModel] = ChatMessageModel.mocks
    @State private var avatar: AvatarModel? = .mock
    @State private var currentUser: UserModel? = .mock
    @State private var textFieldText: String = ""

    @State private var showChatSetting: Bool = false
    @State private var scrolPosition: String?

    var body: some View {
        VStack(spacing: 0) {
            scrollViewSection
            textFieldSection
        }
        .navigationTitle(avatar?.name ?? "Chat")
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Image(systemName: "ellipsis")
                    .padding(8)
                    .anyButton(.plain) {
                        onChatSettingsPressed()
                    }
            }
        }
        .confirmationDialog("", isPresented: $showChatSetting) {
            Button("Report User / Chat", role: .destructive) {

            }

            Button("Delete Chat", role: .destructive) {

            }
        } message: {
            Text("What would you like to do?")
        }

    }

    private var scrollViewSection: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                ForEach(chatMessages) { message in
                    let isCurrentUser = message.authorId == currentUser?.userId
                    ChatBubbleViewBuilder(
                        message: message,
                        isCurretUser: isCurrentUser,
                        imageName: isCurrentUser ? nil : avatar?.profileImageName
                    )
                    .id(message.id)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(8)
            .rotationEffect(.degrees(180))
        }
        .rotationEffect(.degrees(180))
        .scrollPosition(id: $scrolPosition, anchor: .center)
        .animation(.default, value: chatMessages.count)
        .animation(.default, value: scrolPosition)

    }

    private var textFieldSection: some View {
        TextField("Say somting...", text: $textFieldText)
            .keyboardType(.alphabet)
            .autocorrectionDisabled()
            .padding(12)
            .padding(.trailing, 60)
            .overlay(
                Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 32))
                    .padding(.trailing, 4)
                    .foregroundStyle(.accent)
                    .anyButton(.plain, action: {
                        onSendMessagepressed()
                    }),
                alignment: .trailing
            )
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 100)
                        .fill(Color(.systemBackground))
                    RoundedRectangle(cornerRadius: 100)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                }
            )
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color(.secondarySystemBackground))
    }

    private func onSendMessagepressed() {
        guard let currentUser else { return }
        let content = textFieldText

        let message = ChatMessageModel(
            id: UUID().uuidString,
            chatId: UUID().uuidString,
            authorId: currentUser.userId,
            content: content,
            seenByIds: nil,
            dateCreated: .now
        )
        chatMessages.append(message)

        scrolPosition = message.id

        textFieldText = ""
    }

    private func onChatSettingsPressed() {
        showChatSetting = true
    }
}

#Preview {
    NavigationStack {
        ChatView()
    }
}
