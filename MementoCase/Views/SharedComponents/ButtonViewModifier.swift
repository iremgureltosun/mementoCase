//
//  ButtonViewModifier.swift
//  MementoCase
//
//  Created by İrem Tosun on 31.10.2024.
//

import SwiftUI

struct ButtonViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(5)
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)
    }
}

extension View {
    func customButtonStyle() -> some View {
        self.modifier(ButtonViewModifier())
    }
}
