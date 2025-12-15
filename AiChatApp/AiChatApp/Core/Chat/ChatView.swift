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
    @State private var scrolPosition: String?

    @State private var showAlert: AnyAppAlert?
    @State private var showChatSetting: AnyAppAlert?
    @State private var showProfileModal: Bool = false

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
        .showCustomAlert(type: .confirmationDialog, alert: $showChatSetting)
        .showCustomAlert(alert: $showAlert)
        .showModal(showModal: $showProfileModal) {
            profileModal(avatar: avatar)
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
                        imageName: isCurrentUser ? nil : avatar?.profileImageName,
                        onImageTap: onAvatarImageTapped
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

    private func profileModal(avatar: AvatarModel?) -> some View {
        ProfileModalView(
            imageName: avatar?.profileImageName,
            title: avatar?.name,
            subtTitle: avatar?.characterOption?.rawValue.capitalized,
            headLine: avatar?.characterDescription,
            onXMarkTap: {
                showProfileModal = false
            }
        )
        .padding(40)
        .transition(.slide)
    }

    private func onSendMessagepressed() {
        guard let currentUser else { return }
        let content = textFieldText

        do {
            try TextValidationHelper.checkIfTextIsValid(text: content)

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
        } catch {
            showAlert = AnyAppAlert(error: error)
        }
    }

    private func onChatSettingsPressed() {
        showChatSetting = AnyAppAlert(
            title: "",
            subtitle: "What would you like to do?",
            buttons: {
                AnyView(
                    Group {
                        Button("Report User / Chat", role: .destructive) {

                        }

                        Button("Delete Chat", role: .destructive) {

                        }
                    }
                )
            }
        )
    }

    private func onAvatarImageTapped() {
        showProfileModal = true
    }
}

#Preview {
    NavigationStack {
        ChatView()
    }
}
