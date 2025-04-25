//
//  ChatsView.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 2/13/25.
//
import SwiftUI
struct ChatsView: View {

    @State private var chats: [ChatModel] = ChatModel.mocks

    var body: some View {
        NavigationStack {
            List {
                ForEach(chats) { chat in
                    Text(chat.id)
                }
            }
            .navigationTitle("Chats")
        }
    }
}

#Preview {
    ChatsView()
}
