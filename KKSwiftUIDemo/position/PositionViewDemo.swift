//
//  PositionViewDemo.swift
//  KKSwiftUIDemo
//
//  Created by jyrnan on 2025/5/4.
//

import SwiftUI

struct PositionViewDemo: View {
    var body: some View {
        GeometryReader { proxy in
            
            Color.red
                .border(.green, width: 2)
//                .ignoresSafeArea()
                .overlay {
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                        .font(.largeTitle)
                        .border(.blue, width: 2)
                        .position(x: 0, y: 0)
                        .task {
                            print("position: \(proxy.frame(in: .global).origin)")
                            print("position: \(proxy.frame(in: .global).size)")
                            print("inset: \(proxy.safeAreaInsets)")
                        }
                }
            
        }
        .border(.blue, width: 2)
        .ignoresSafeArea()
    }
}

#Preview {
    PositionViewDemo()
}
