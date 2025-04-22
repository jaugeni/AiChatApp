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
    var body: some View {
        NavigationView {
            List {
                featuredSection
                categoriesSection
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
                }
            }
            .removeListRowFormating()
        } header: {
            Text("Featured Avatars")
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
}

#Preview {
    ExploreView()
}
