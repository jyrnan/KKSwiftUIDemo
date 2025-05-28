//
//  ComplexScrollAnimation.swift
//  KKSwiftUIDemo
//
//  Created by jyrnan on 2025/5/8.
//

import SwiftUI

struct ComplexScrollAnimation: View {
    
    @State private var activeCard: Int?
    /// Environment
    @Environment(\.colorScheme) private var scheme
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 15) {
                    Text("Header \(activeCard ?? 0)")
                        .font(.largeTitle)
                        .bold()
                        .frame(height: 45)
                        .padding(.horizontal, 15)
                    
                    GeometryReader { proxy in
                        let rect = proxy.frame(in: .scrollView)
                        let minY = rect.minY.rounded()
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 0) {
                                ForEach(0..<10, id: \.self) { index in
                                    ZStack {
                                        if minY == 75.0 {
                                            /// 没滚动
                                            cardView(index)
                                        } else {
                                            /// 滚动
                                            if activeCard == index {
                                                cardView(index)
                                                    
                                            } else {
                                                Rectangle()
                                                    .fill(.clear)
                                                
                                            }
                                        }
                                    }
                                    .containerRelativeFrame(.horizontal)
                                }
                            }
                            .scrollTargetLayout()
                        }
                        .scrollPosition(id: $activeCard)
                        .scrollTargetBehavior(.paging)
                        .scrollClipDisabled()
                        .scrollIndicators(.hidden)
                        .scrollDisabled(minY != 75.0)
                    }
                    .frame(height: 125)
                }
                
                LazyVStack(spacing: 15) {
                    Menu {} label: {
                        HStack(spacing: 4) {
                            Text("Filter by")
                            Image(systemName: "chevron.down")
                        }
                        .font(.caption)
                        .foregroundStyle(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                   
                        ForEach(0..<415) { index in
                            listView(index)
                        }
                    
                }
                .padding(15)
                .mask({
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .visualEffect { content, proxy in
                            content
                                .offset(y: backgroundLimitOffset(proxy))
                        }
                })
                .background {
                    GeometryReader{ proxy in
                        let rect = proxy.frame(in: .scrollView)
                        let minY = min(rect.minY - 125, 0)
                        let progress = max(min(-minY / 25, 1), 0)
                        
                        RoundedRectangle(cornerRadius: 30 * progress, style: .continuous)
                            .fill(.background)
                            .visualEffect { content, proxy in
                                content
                                    .offset(y: backgroundLimitOffset(proxy))
                            }
                    }
                }
            }
            .padding(.vertical, 15)
        }
        .scrollTargetBehavior(CustomScrollTarget())
        .scrollIndicators(.hidden)
        .onAppear {
            if activeCard == nil {
                activeCard = 0
            }
        }
    }
    // MARK: - 背景偏移限制
    func backgroundLimitOffset(_ proxy: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .scrollView).minY
        let limit = 100.0 // 这里决定了下面的内容能上移动到距离scrollView的顶部多少
        
        return minY < limit ? -minY + limit : 0
    }
        
    
    // MARK: - Card View

    @ViewBuilder
    func cardView(_ index: Int) -> some View {
        GeometryReader { proxy in
            let rect = proxy.frame(in: .scrollView(axis: .vertical))
            let minY = rect.minY
            let topValue: CGFloat = 75.0
            
            let offset = min(minY - topValue, 0)
            let progress = max(min(-offset / topValue, 1), 0)
            let scale = 1 + progress
            
            let _ = print(minY)
            
            ZStack {
                Rectangle()
                    .fill(.blue)
                    .overlay(alignment: .leading) {
                        Circle()
                            .fill(.blue)
                            .overlay {
                                Circle()
                                    .fill(.white.opacity(0.2))
                            }
                            .scaleEffect(2, anchor: .topLeading)
                            .offset(x: -50, y: -40)
                    }
                   
                    .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                    .scaleEffect(scale, anchor: .bottom)
                
                VStack(alignment: .leading, spacing: 4) {
                    Spacer(minLength: 0)
                    Text("Item \(index)")
                        .foregroundStyle(.white)
                        .font(.title2)
                        .bold()
                    
                    Text("Current Balance \(progress)")
                        .foregroundStyle(.white)
                        .font(.callout)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(15)
                .offset(y: progress * -25)
            }
            .offset(y: -offset) // 使其在滚动时保持在顶部
            .offset(y: progress * -topValue)// 使其在滚动时保持在顶部但同时会向上一段距离
        }
        .padding(.horizontal, 15)
    }
        
    // MARK: - Helper

    @ViewBuilder
    func listView(_ index: Int) -> some View {
        Text("Item \(index)").foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
//            .padding(.horizontal)
            .padding(.vertical, 5)
    }
}

/// MARK: - ScrollTarget
struct CustomScrollTarget: ScrollTargetBehavior {
    func updateTarget(_ target: inout ScrollTarget, context: TargetContext) {
        if target.rect.minY < 75 {
            target.rect = .zero
        }
    }
}

#Preview {
    ComplexScrollAnimation()
}
