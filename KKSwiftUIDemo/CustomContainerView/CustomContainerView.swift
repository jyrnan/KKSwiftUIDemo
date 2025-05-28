//
//  CustomContainerView.swift
//  KKSwiftUIDemo
//
//  Created by jyrnan on 2025/5/19.
//

import SwiftUI

struct CustomContainerView<Content: View>: View {
    @ViewBuilder let content: Content
    var body: some View {
        content
            .padding()
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    CustomContainerView {
        Text("Hello, World!")
    }
}
