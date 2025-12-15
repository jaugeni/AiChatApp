//
//  ProfileModalView.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 4/30/25.
//

import SwiftUI

struct ProfileModalView: View {

    var imageName: String? = Constants.randomImage
    var title: String? = "Alpha"
    var subtTitle: String? = "Alien"
    var headLine: String? = "An Alien in the park"
    var onXMarkTap: () -> Void = { }

    var body: some View {
        VStack(spacing: 0) {
            if let imageName {
                ImageLoaderView(
                    urlString: imageName,
                    forceTransitionAnimation: true
                )
                .aspectRatio(1, contentMode: .fit)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                if let title {
                    Text(title)
                        .font(.title)
                        .fontWeight(.semibold)
                }
                
                if let subtTitle {
                    Text(subtTitle)
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
                
                if let headLine {
                    Text(headLine)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .padding(24)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(.thinMaterial)
        .cornerRadius(16)
        .overlay(
            Image(systemName: "xmark.circle.fill")
                .font(.title)
                .foregroundStyle(Color.black)
                .padding(4)
                .tappableBackground()
                .anyButton {
                    onXMarkTap()
                }
                .padding(8),
            alignment: .topTrailing
        )
    }
}

#Preview("Modal w/ Image") {
    ZStack {
        Color.gray.ignoresSafeArea()

        ProfileModalView()
            .padding(40)
    }
}

#Preview("Modal w/out Image") {
    ZStack {
        Color.gray.ignoresSafeArea()

        ProfileModalView(imageName: nil)
            .padding(40)
    }
}
