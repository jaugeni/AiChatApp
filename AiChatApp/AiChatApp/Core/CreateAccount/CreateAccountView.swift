//
//  CreateAccountView.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 4/28/25.
//

import SwiftUI

struct CreateAccountView: View {

    @Environment(\.dismiss) private var dismiss
    @Environment(AuthManager.self) private var authManager
    @Environment(UserManager.self) private var userManager

    var title: String = "Create Account?"
    var subTitle: String = "Don't lose your data! Connect to an SSO provider to save your account."
    var onDidSignIn: ((_ isNewuser: Bool) -> Void)?

    var body: some View {
        VStack(spacing: 24) {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                Text(subTitle)
                    .font(.body)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            SignInWithAppleButtonView(
                type: .signIn,
                style: .black,
                cornerRadius: 10
            )
            .frame(height: 55)
            .anyButton(.press) {
                onSignInAppleTap()
            }

            Spacer()
        }
        .padding(16)
        .padding(.top, 40)
    }

    func onSignInAppleTap() {
        Task {
            do {
                let result = try await authManager.signInApple()
                print("Did sign in with apple result: \(result.user.uid)")


                try await userManager.logIn(auth: result.user, isNewUser: result.isNewUser)
                print("Did log in")

                onDidSignIn?(result.isNewUser)
                dismiss()
            } catch {
                print("Error signInApple: \(error)")
            }
        }
    }
}

#Preview {
    CreateAccountView()
}
