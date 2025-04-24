//
//  Views+EXT.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 4/21/25.
//

import SwiftUI

extension View {
    func callToActionButton() -> some View {
        self
            .font(.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(.accent)
            .cornerRadius(16)
    }

    func tappableBackground() -> some View {
        contentShape(Rectangle())
    }

    func removeListRowFormating() -> some View {
        self
            .listRowInsets(EdgeInsets(top: .zero, leading: .zero, bottom: .zero, trailing: .zero))
            .listRowBackground(Color.clear)
    }

    func addingGradientBackgroundForText() -> some View {
        background(
            LinearGradient(
                colors: [
                    Color.black.opacity(0),
                    Color.black.opacity(0.3),
                    Color.black.opacity(0.4)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }

    func cornerRadius(_ radius: CGFloat) -> some View {
        clipShape(.rect(cornerRadius: radius))
    }
}
