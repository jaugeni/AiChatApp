//
//  ExploreView.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 2/13/25.
//

import SwiftUI

struct ExploreView: View {

    @State private var featureAvatars: [AvatarModel] = AvatarModel.mocks
    @State private var categories: [CharacterOption] = CharacterOption.allCases
    @State private var poupularAvatars: [AvatarModel] = AvatarModel.mocks

    var body: some View {
        NavigationView {
            List {
                featuredSection
                categoriesSection
                popularSection
            }
            .navigationTitle("Explore")
        }
    }

    private var featuredSection: some View {
        Section {
            ZStack {
                CarouselView(items: featureAvatars) { item in
                    HeroCellView(
                        title: item.name,
                        subtitle: item.characterDescription,
                        imageName: item.profileImageName
                    )
                    .anyButton {

                    }
                }
            }
            .removeListRowFormating()
        } header: {
            Text("Featured")
        }
    }

    private var categoriesSection: some View {
        Section {
            ZStack {
                ScrollView(.horizontal) {
                    HStack(spacing: 12) {
                        ForEach(categories, id: \.self) { category in
                            CategoryCellView(
                                title: category.rawValue.capitalized,
                                imageName: Constants.randomImage
                            )
                            .anyButton {

                            }
                        }
                    }
                }
                .frame(height: 140)
                .scrollIndicators(.hidden)
                .scrollTargetLayout()
                .scrollTargetBehavior(.viewAligned)
            }
            .removeListRowFormating()
        } header: {
            Text("Categories")
        }
    }

    private var popularSection: some View {
        Section {
            ForEach(poupularAvatars, id: \.self) { avatar in
                CustomListCellView(
                    imageName: avatar.profileImageName,
                    title: avatar.name,
                    subtitle: avatar.characterDescription
                )
                .anyButton(.highlight) {

                }
                .removeListRowFormating()
            }
        } header: {
            Text("Popular")
        }
    }
}

#Preview {
    ExploreView()
}
