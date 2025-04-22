//
//  ExploreView.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 2/13/25.
//

import SwiftUI

struct ExploreView: View {

    let avatar = AvatarModel.mock

    var body: some View {
        NavigationView {
            HeroCellView(
                title: avatar.name,
                subtitle: avatar.characterDescription,
                imageName: avatar.profileImageName
            )
            .navigationTitle("Explore")
        }
    }
}

#Preview {
    ExploreView()
}
