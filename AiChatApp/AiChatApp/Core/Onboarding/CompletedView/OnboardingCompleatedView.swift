//
//  OnboardingCompleatedView.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 4/21/25.
//

import SwiftUI

struct OnboardingCompleatedView: View {

    @Environment(AppState.self) private var root

    var body: some View {
        VStack {
            Text("Onboarding completed!")
                .frame(maxHeight: .infinity)

            Button {
                onFicnishButtonPressed()
            } label: {
                Text("Finish")
                    .callToActionButton()
            }
        }
        .padding(16)
    }

    func onFicnishButtonPressed() {
        // other logic to compleat onboarding
        root.updateViewState(showTabBarView: true)
    }
}

#Preview {
    OnboardingCompleatedView()
        .environment(AppState())
}
