//
//  Splitview.swift
//  KKSwiftUIDemo
//
//  Created by jyrnan on 2025/5/16.
//

import SwiftUI

struct Splitview: View {
    @State private var isShowing = false
    @State private var sheetHeight: CGFloat = 0
    
    @State private var prevOffsetHeight: CGFloat = 0
    
    var gapWidth: CGFloat {
        sheetHeight > 0 ? 8 : 0
    }

    var body: some View {
        GeometryReader { geo in
            let sheetMinHeight: CGFloat = geo.size.height * 0.3
            let sheetMaxHeight = geo.size.height * 0.7
            ZStack {
                Color.orange
                
                Color.yellow
                    .mask {
                        RoundedRectangle(cornerRadius: 48)
                            .padding(.bottom, sheetHeight + gapWidth)
                    }
                
                RoundedRectangle(cornerRadius: 48)
                    .foregroundStyle(.blue)
                    .frame(height: sheetHeight)
                    
                    .overlay {
                        ScrollView {
                            VStack{
                                ForEach(1..<10) {index in
                                    Text("Item \(index)")
                                        .font(.largeTitle)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                    
                                }
                            }
                        }
                        .scrollDisabled(sheetHeight < sheetMaxHeight)
                        .padding()
                    }
                    .offset(y: geo.size.height / 2 - sheetHeight / 2)
                    .gesture(DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            let deltaY = value.translation.height - prevOffsetHeight
                            prevOffsetHeight = value.translation.height
                            sheetHeight += -deltaY
                            if sheetHeight < 40 {
                                sheetHeight = 0
                            }
                            sheetHeight = max(min(sheetMaxHeight, sheetHeight), 0)
                        }
                        .onEnded { _ in
                            prevOffsetHeight = 0
                            if sheetHeight < sheetMinHeight {
                                sheetHeight = 0
                            }
                        }
                    )
                
                RoundedRectangle(cornerRadius: 5)
                    .foregroundStyle(.red)
                    .frame(width: 50, height: 10)
                    .offset(y: geo.size.height / 2 - sheetHeight + 12)
//                    .gesture(DragGesture(minimumDistance: 0)
//                        .onChanged { value in
//                            let deltaY = value.translation.height - prevOffsetHeight
//                            prevOffsetHeight = value.translation.height
//                            sheetHeight += -deltaY
//                            if sheetHeight < 40 {
//                                sheetHeight = 0
//                            }
//                            sheetHeight = max(min(700, sheetHeight), 0)
//                        }
//                        .onEnded { _ in
//                            prevOffsetHeight = 0
//                        }
//                    )
                
//                                .onGeometryChange(for: CGFloat.self) { proxy in
//                                    proxy.frame(in: .global).origin.y
//                                } action: { newValue in
//                                    print("origin: \(newValue)")
//                                }
                                    
                Button {
                    if sheetHeight == 0 {
                        sheetHeight = sheetMinHeight
                        
                    } else {
                        sheetHeight = 0
                    }
                } label: {
                    Text("Hello, World!")
                }
            }
//            .border(.blue, width: 4)
            .animation((sheetHeight == sheetMinHeight  || sheetHeight == 0) ? .default : .none, value: sheetHeight)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    Splitview()
}

#Preview("Sheet") {
    Color.red
        .ignoresSafeArea()
        .sheet(isPresented: .constant(true)) {
            Splitview()
                .presentationDetents([.height(300), .medium, .large])
                .presentationCornerRadius(48)
        }
}

