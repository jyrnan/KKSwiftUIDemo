//
//  ShakeEffectDemo.swift
//  KKSwiftUIDemo
//
//  Created by jyrnan on 2025/5/3.
//

import SwiftUI

struct ShakeEffectDemo: View {
    @State private var trigger: Int = 0

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .keyframeAnimator(
                initialValue: 0,
                trigger: trigger,
                content: { content, offset in
                    content
                        .offset(x: offset)
                        
                },
                keyframes: { _ in
                    KeyframeTrack{
                        LinearKeyframe(0, duration: 0)
                        LinearKeyframe(10, duration: 0.1)
                        LinearKeyframe(-10, duration: 0.1)
                        LinearKeyframe(8, duration: 0.1)
                        LinearKeyframe(-8, duration: 0.1)
                        LinearKeyframe(0, duration: 0.1)

                    }
                }
            )
            .onTapGesture {
                trigger += 1
            }
                
    }
}

#Preview {
    ShakeEffectDemo()
}
