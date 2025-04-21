//
//  WelcomeView.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 2/13/25.
//

import SwiftUI

struct WelcomeView: View {

    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome to AiChatApp")
                    .frame(maxHeight: .infinity)

                NavigationLink {
                    OnboardingCompleatedView()
                } label: {
                    Text("Get Started")
                        .callToActionButton()
                }
            }
            .padding(16)
        }
    }
}

#Preview {
    WelcomeView()
}
