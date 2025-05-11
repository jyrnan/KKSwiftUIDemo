//
//  KeyFrame.swift
//  KKSwiftUIDemo
//
//  Created by jyrnan on 2025/5/1.
//

import SwiftUI

struct KeyFrame: View {
    @State var outViewSize: CGSize = .zero
    @State var inViewSize: CGSize = .zero
    var body: some View {
        Rectangle()
            .onGeometryChange(for: CGSize.self, of: { proxy in
                proxy.size
            }, action: { newValue in
                outViewSize = newValue
            })
            .overlay(alignment: .leading) {
                Text("Hello, World! This the new world!This the new world!This the new world!This the new world!")
                    .fixedSize()
                    .onGeometryChange(for: CGSize.self, of: { proxy in
                        proxy.size
                    }, action: { newValue in
                        inViewSize = newValue
                    })
                    .background(.background)
                    .keyframeAnimator(initialValue: 0, repeating: true) { content,  value in
                        content
                            .overlay(alignment: .trailing) {
                                content.offset(x: inViewSize.width)
                            }
//                            .offset(x: -200 * value)
                            .offset(x: (-inViewSize.width) * value)
//                            .scaleEffect(value)
                        
                    } keyframes: { value in
                        LinearKeyframe(0, duration: 2)
                        LinearKeyframe(1, duration: 5)
                    }
            }
    }
}

#Preview {
    KeyFrame()
}
