//
//  WelcomeView.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 2/13/25.
//

import SwiftUI

struct WelcomeView: View {
    @State var imageName: String = Constants.randomImage
    @State var showSignInView: Bool = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 8) {
                ImageLoaderView(urlString: imageName)
                    .ignoresSafeArea()

                titleSection
                    .padding(.top, 24)

                ctaButtons
                    .padding(16)

                policyLinks
            }
            .sheet(isPresented: $showSignInView) {
                CreateAccountView(
                    title: "Sign in",
                    subTitle: " Connect to an existing account."
                )
                .presentationDetents([.medium])
            }
        }
    }

    private var titleSection: some View {
        VStack(spacing: 8) {
            Text("AI Chat 🤖")
                .font(.largeTitle)
                .fontWeight(.semibold)

            Text("Learning project")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    private var ctaButtons: some View {
        VStack(spacing: 8) {
            NavigationLink {
                OnboardingIntroView()
            } label: {
                Text("Get Started")
                    .callToActionButton()
            }

            Text("Already have an account? Sign in.")
                .underline()
                .font(.body)
                .padding(8)
                .tappableBackground()
                .onTapGesture {
                    onSignInPressed()
                }
        }
    }

    private var policyLinks: some View {
        HStack(spacing: 8) {
            Link(
                destination: URL(string: Constants.privacyPolicyUrl)!
            ) {
                Text("Terms of Service")
            }

            Circle()
                .fill(.accent)
                .frame(width: 4, height: 4)

            Link(
                destination: URL(string: Constants.termsOfServiceUrl)!
            ) {
                Text("Privacy Policy")
            }
        }
    }

    private func onSignInPressed() {
        showSignInView = true
    }
}

#Preview {
    WelcomeView()
}
