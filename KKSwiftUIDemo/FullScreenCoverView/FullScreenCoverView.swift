//
//  FullScreenCoverView.swift
//  KKSwiftUIDemo
//
//  Created by jyrnan on 2025/5/15.
//

import SwiftUI

struct FullScreenCoverView: View {
    @Environment(\.dismiss) var dismiss
        @State private var isFirstCoverPresented = false
        @State private var isSecondCoverPresented = false

        var body: some View {
            VStack {
                Button("显示第1个全屏") {
                    isFirstCoverPresented = true
                }
                Button("显示第2个全屏") {
                    
                    isSecondCoverPresented = true
                }

            }
                .fullScreenCover(isPresented: $isFirstCoverPresented) {
                    ZStack {
                        Color.red
                            .ignoresSafeArea()
                        VStack {
                            Text("第一个全屏")
                            Button("关闭第一个全屏") {
                                isFirstCoverPresented = false
                            }
                            Button("显示第二个全屏") {
                                isSecondCoverPresented = true
                            }
                            
                        }
                    }
                    .sheet(isPresented: $isSecondCoverPresented) {
                        Text("第二个版屏")
                            .presentationDetents([.medium, .large])
                    }
                }
                .fullScreenCover(isPresented: $isSecondCoverPresented) {
                    Text("第二个全屏")
                        .onTapGesture {
                            isSecondCoverPresented.toggle()
                        }
                }
            
        }
    }

#Preview {
    FullScreenCoverView()
}
