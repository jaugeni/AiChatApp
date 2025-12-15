//
//  CategoryListView.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 12/15/25.
//

import SwiftUI

struct CategoryListView: View {

    @Binding var path: [NavigationPathOption]
    var category: CharacterOption = .alien
    var imageName: String = Constants.randomImage
    @State private var avatars: [AvatarModel] = AvatarModel.mocks

    var body: some View {
        List {
            CategoryCellView(
                title: category.plural.capitalized,
                imageName: imageName,
                font: .largeTitle,
                cornerRadius: 0
            )
            .removeListRowFormating()

            ForEach(avatars, id: \.self) { avatar in
                CustomListCellView(
                    imageName: avatar.profileImageName,
                    title: avatar.name,
                    subtitle: avatar.characterDescription
                )
                .anyButton(.highlight) {
                    onAvatarTapped(avatar: avatar)
                }
                .removeListRowFormating()
            }
        }
        .navigationDestinationForCoreModule(path: $path)
        .ignoresSafeArea()
        .listStyle(.plain)
    }

    private func onAvatarTapped(avatar: AvatarModel) {
        path.append(.chat(avatarId: avatar.avatarId))
    }
}

#Preview {
    CategoryListView(path: .constant([]))
}
