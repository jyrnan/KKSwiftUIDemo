//
//  GestureRecognitionDemo.swift
//  KKSwiftUIDemo
//
//  Created by jyrnan on 2025/6/25.
//

import SwiftUI

struct GestureRecognitionDemo: View {
    @State private var offset = CGSize.zero
    @State private var scale: CGFloat = 1.0
    @State private var rotation: Angle = .zero
    @State private var tapCount = 0
    @State private var longPressTriggered = false
    @State private var dragDistance: CGFloat = 0
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    // 拖拽手势演示
                    dragGestureDemo
                    
                    // 缩放手势演示
                    magnificationGestureDemo
                    
                    // 旋转手势演示
                    rotationGestureDemo
                    
                    // 点击手势演示
                    tapGestureDemo
                    
                    // 长按手势演示
                    longPressGestureDemo
                    
                    // 复合手势演示
                    compositeGestureDemo
                }
                .padding()
            }
            .navigationTitle("手势识别演示")
        }
    }
    
    // MARK: - 拖拽手势演示
    private var dragGestureDemo: some View {
        VStack {
            Text("拖拽手势")
                .font(.headline)
            
            Text("距离: \(Int(dragDistance))")
                .font(.caption)
                .foregroundColor(.secondary)
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.blue.gradient)
                .frame(width: 100, height: 100)
                .offset(offset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            offset = value.translation
                            dragDistance = sqrt(pow(value.translation.width, 2) + pow(value.translation.height, 2))
                        }
                        .onEnded { _ in
                            withAnimation(.spring()) {
                                offset = .zero
                                dragDistance = 0
                            }
                        }
                )
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(15)
    }
    
    // MARK: - 缩放手势演示
    private var magnificationGestureDemo: some View {
        VStack {
            Text("缩放手势")
                .font(.headline)
            
            Text("缩放: \(scale, specifier: "%.2f")x")
                .font(.caption)
                .foregroundColor(.secondary)
            
            Circle()
                .fill(Color.red.gradient)
                .frame(width: 80, height: 80)
                .scaleEffect(scale)
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            scale = value
                        }
                        .onEnded { _ in
                            withAnimation(.spring()) {
                                scale = 1.0
                            }
                        }
                )
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(15)
    }
    
    // MARK: - 旋转手势演示
    private var rotationGestureDemo: some View {
        VStack {
            Text("旋转手势")
                .font(.headline)
            
            Text("角度: \(rotation.degrees, specifier: "%.1f")°")
                .font(.caption)
                .foregroundColor(.secondary)
            
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.green.gradient)
                .frame(width: 100, height: 60)
                .rotationEffect(rotation)
                .gesture(
                    RotationGesture()
                        .onChanged { value in
                            rotation = value
                        }
                        .onEnded { _ in
                            withAnimation(.spring()) {
                                rotation = .zero
                            }
                        }
                )
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(15)
    }
    
    // MARK: - 点击手势演示
    private var tapGestureDemo: some View {
        VStack {
            Text("点击手势")
                .font(.headline)
            
            Text("点击次数: \(tapCount)")
                .font(.caption)
                .foregroundColor(.secondary)
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.orange.gradient)
                .frame(width: 120, height: 80)
                .overlay(
                    Text("点击我")
                        .foregroundColor(.white)
                        .font(.headline)
                )
                .scaleEffect(tapCount > 0 ? 1.1 : 1.0)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.1)) {
                        tapCount += 1
                    }
                }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(15)
    }
    
    // MARK: - 长按手势演示
    private var longPressGestureDemo: some View {
        VStack {
            Text("长按手势")
                .font(.headline)
            
            Text(longPressTriggered ? "长按已触发!" : "长按试试")
                .font(.caption)
                .foregroundColor(longPressTriggered ? .green : .secondary)
            
            RoundedRectangle(cornerRadius: 20)
                .fill(longPressTriggered ? Color.green.gradient : Color.purple.gradient)
                .frame(width: 120, height: 80)
                .overlay(
                    Text("长按我")
                        .foregroundColor(.white)
                        .font(.headline)
                )
                .scaleEffect(longPressTriggered ? 1.2 : 1.0)
                .onLongPressGesture(minimumDuration: 1.0) {
                    withAnimation(.spring()) {
                        longPressTriggered.toggle()
                    }
                    
                    // 2秒后重置状态
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation(.spring()) {
                            longPressTriggered = false
                        }
                    }
                }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(15)
    }
    
    // MARK: - 复合手势演示
    private var compositeGestureDemo: some View {
        VStack {
            Text("复合手势")
                .font(.headline)
            
            Text("可以同时拖拽、缩放和旋转")
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.pink.gradient)
                .frame(width: 100, height: 100)
                .offset(offset)
                .scaleEffect(scale)
                .rotationEffect(rotation)
                .gesture(
                    SimultaneousGesture(
                        DragGesture()
                            .onChanged { value in
                                offset = value.translation
                            }
                            .onEnded { _ in
                                withAnimation(.spring()) {
                                    offset = .zero
                                }
                            },
                        SimultaneousGesture(
                            MagnificationGesture()
                                .onChanged { value in
                                    scale = value
                                }
                                .onEnded { _ in
                                    withAnimation(.spring()) {
                                        scale = 1.0
                                    }
                                },
                            RotationGesture()
                                .onChanged { value in
                                    rotation = value
                                }
                                .onEnded { _ in
                                    withAnimation(.spring()) {
                                        rotation = .zero
                                    }
                                }
                        )
                    )
                )
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(15)
    }
}

#Preview {
    GestureRecognitionDemo()
}
