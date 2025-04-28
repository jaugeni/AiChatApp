//
//  AsyncCallTOActionButton.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 4/28/25.
//

import SwiftUI

struct AsyncCallTOActionButton: View {

    var isLoading: Bool = false
    var title: String = "Save"
    var action: () -> Void

    var body: some View {
        ZStack {
            if isLoading {
                ProgressView()
                    .tint(.white)
            } else {
                Text(title)
            }
        }
        .callToActionButton()
        .anyButton(.press) {
            action()
        }
        .disabled(isLoading)
    }
}

#Preview {
    @Previewable @State var isLoading: Bool = false

    AsyncCallTOActionButton(
        isLoading: isLoading,
        title: "Finish",
        action: {
            isLoading = true

            Task {
                try? await Task.sleep(for: .seconds(3))
                isLoading = false
            }
        }
    )
    .padding()
}
