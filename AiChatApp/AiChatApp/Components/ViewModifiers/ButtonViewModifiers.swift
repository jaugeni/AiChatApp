//
//  ButtonViewModifiers.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 4/24/25.
//

import SwiftUI

struct HighlightButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .overlay {
                configuration.isPressed ? Color.accent.opacity(0.4) : Color.accent.opacity(0)
            }
            .animation(.smooth, value: configuration.isPressed)
    }
}

struct PressebaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.smooth, value: configuration.isPressed)
    }
}

enum ButtoStyleOption {
    case press, highlight, plain
}

extension View {

    @ViewBuilder
    func anyButton(
        _ option: ButtoStyleOption = .plain,
        action: @escaping () -> Void
    ) -> some View {
        switch option {
        case .press:
            self.pressebaleButton(action: action)
        case .highlight:
            self.highlightButton(action: action)
        case .plain:
            self.plaintButton(action: action)
        }
    }

    private func plaintButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            self
        }
        .buttonStyle(PlainButtonStyle())
    }

    private func highlightButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            self
        }
        .buttonStyle(HighlightButtonStyle())
    }

    private func pressebaleButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            self
        }
        .buttonStyle(PressebaleButtonStyle())
    }
}

#Preview {
    VStack {
        Text("Highlight")
            .padding()
            .frame(maxWidth: .infinity)
            .tappableBackground()
            .anyButton(.highlight) { }

        Text("Pressebale")
            .frame(maxWidth: .infinity)
            .callToActionButton()
            .anyButton(.press) { }
            .padding()

        Text("Plain")
            .frame(maxWidth: .infinity)
            .callToActionButton()
            .anyButton(.plain) { }
            .padding()
    }
}
