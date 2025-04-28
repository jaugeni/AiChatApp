//
//  OnboardingCompleatedView.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 4/21/25.
//

import SwiftUI

struct OnboardingCompleatedView: View {

    @Environment(AppState.self) private var root
    @State private var isComleatingProfileSetup: Bool = false
    var selectedColor: Color = .orange

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Setup complete!")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(selectedColor)

            Text("We've set up for profile and you're ready to start chatting.")
                .font(.title)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)
        }
        .frame(maxHeight: .infinity)
        .safeAreaInset(edge: .bottom, content: {
            AsyncCallTOActionButton(
                isLoading: isComleatingProfileSetup,
                title: "Finish",
                action: onFicnishButtonPressed
            )
        })
        .padding(24)
        .toolbarVisibility(.hidden, for: .navigationBar)
    }

    func onFicnishButtonPressed() {
        isComleatingProfileSetup = true

        Task {
            try await Task.sleep(for: .seconds(3))
            isComleatingProfileSetup = false
            // try await saveUserProfile(color: selectedColor)

            root.updateViewState(showTabBarView: true)
        }
    }
}

#Preview {
    OnboardingCompleatedView(selectedColor: .mint)
        .environment(AppState())
}
