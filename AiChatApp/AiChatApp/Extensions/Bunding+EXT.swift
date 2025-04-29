//
//  Bunding+EXT.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 4/29/25.
//

import SwiftUI

extension Binding where Value == Bool {
    init<T: Sendable>(ifNotNil value: Binding<T?>) {
        self.init {
            value.wrappedValue != nil
        } set: { newValue in
            if !newValue {
                value.wrappedValue = nil
            }
        }

    }
}
