//
//  CardFlipAnimationDemo.swift
//  KKSwiftUIDemo
//
//  Created by jyrnan on 2025/6/25.
//

import SwiftUI

struct CardFlipAnimationDemo: View {
    @State private var isFlipped = false
    @State private var selectedCard: Int? = nil
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    // 单张卡片翻转演示
                    singleCardDemo
                    
                    // 多张卡片网格演示
                    cardGridDemo
                    
                    // 记忆卡片游戏演示
                    memoryCardDemo
                }
                .padding()
            }
            .navigationTitle("卡片翻转动画")
        }
    }
    
    // MARK: - 单张卡片演示
    private var singleCardDemo: some View {
        VStack(spacing: 20) {
            Text("单张卡片翻转")
                .font(.headline)
            
            FlipCard(
                isFlipped: $isFlipped,
                front: {
                    CardView(
                        title: "正面",
                        subtitle: "点击翻转",
                        color: .blue,
                        icon: "creditcard"
                    )
                },
                back: {
                    CardView(
                        title: "背面",
                        subtitle: "再次点击",
                        color: .red,
                        icon: "creditcard.fill"
                    )
                }
            )
            .frame(width: 200, height: 120)
            .onTapGesture {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                    isFlipped.toggle()
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(15)
    }
    
    // MARK: - 多张卡片网格演示
    private var cardGridDemo: some View {
        VStack(spacing: 20) {
            Text("卡片网格")
                .font(.headline)
            
            let cards = Array(0..<6)
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 10) {
                ForEach(cards, id: \.self) { index in
                    FlipCard(
                        isFlipped: .constant(selectedCard == index),
                        front: {
                            CardView(
                                title: "\(index + 1)",
                                subtitle: "点击查看",
                                color: .green,
                                icon: "questionmark"
                            )
                        },
                        back: {
                            CardView(
                                title: "卡片 \(index + 1)",
                                subtitle: "详细信息",
                                color: .orange,
                                icon: "info.circle"
                            )
                        }
                    )
                    .frame(width: 80, height: 60)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            selectedCard = selectedCard == index ? nil : index
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(15)
    }
    
    // MARK: - 记忆卡片游戏演示
    private var memoryCardDemo: some View {
        VStack(spacing: 20) {
            Text("记忆卡片游戏")
                .font(.headline)
            
            MemoryGameView()
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(15)
    }
}

// MARK: - 翻转卡片组件
struct FlipCard<Front: View, Back: View>: View {
    @Binding var isFlipped: Bool
    let front: () -> Front
    let back: () -> Back
    
    var body: some View {
        ZStack {
            if isFlipped {
                back()
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            } else {
                front()
            }
        }
        .rotation3DEffect(
            .degrees(isFlipped ? 180 : 0),
            axis: (x: 0, y: 1, z: 0)
        )
    }
}

// MARK: - 卡片视图组件
struct CardView: View {
    let title: String
    let subtitle: String
    let color: Color
    let icon: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(color.gradient)
            .overlay(
                VStack(spacing: 8) {
                    Image(systemName: icon)
                        .font(.title2)
                        .foregroundColor(.white)
                    
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                }
            )
            .shadow(color: color.opacity(0.3), radius: 5, x: 0, y: 2)
    }
}

// MARK: - 记忆游戏视图
struct MemoryGameView: View {
    @State private var cards: [MemoryCard] = []
    @State private var flippedCards: Set<Int> = []
    @State private var matchedCards: Set<Int> = []
    @State private var score = 0
    
    private let cardSymbols = ["🍎", "🍌", "🍇", "🍊", "🥝", "🍓"]
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Text("分数: \(score)")
                    .font(.headline)
                
                Spacer()
                
                Button("重新开始") {
                    resetGame()
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 5)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 8) {
                ForEach(cards.indices, id: \.self) { index in
                    let card = cards[index]
                    
                    FlipCard(
                        isFlipped: .constant(flippedCards.contains(index) || matchedCards.contains(index)),
                        front: {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.gray.gradient)
                                .frame(height: 60)
                                .overlay(
                                    Image(systemName: "questionmark")
                                        .foregroundColor(.white)
                                        .font(.title2)
                                )
                        },
                        back: {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(matchedCards.contains(index) ? Color.green.gradient : Color.blue.gradient)
                                .frame(height: 60)
                                .overlay(
                                    Text(card.symbol)
                                        .font(.title)
                                )
                        }
                    )
                    .onTapGesture {
                        cardTapped(at: index)
                    }
                }
            }
        }
        .onAppear {
            setupGame()
        }
    }
    
    private func setupGame() {
        var gameCards: [MemoryCard] = []
        
        // 创建成对的卡片
        for symbol in cardSymbols {
            gameCards.append(MemoryCard(symbol: symbol))
            gameCards.append(MemoryCard(symbol: symbol))
        }
        
        cards = gameCards.shuffled()
        flippedCards.removeAll()
        matchedCards.removeAll()
        score = 0
    }
    
    private func resetGame() {
        withAnimation {
            setupGame()
        }
    }
    
    private func cardTapped(at index: Int) {
        guard !flippedCards.contains(index) && !matchedCards.contains(index) else { return }
        
        withAnimation(.spring()) {
            flippedCards.insert(index)
        }
        
        if flippedCards.count == 2 {
            checkForMatch()
        }
    }
    
    private func checkForMatch() {
        let flippedIndices = Array(flippedCards)
        let firstCard = cards[flippedIndices[0]]
        let secondCard = cards[flippedIndices[1]]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if firstCard.symbol == secondCard.symbol {
                // 匹配成功
                withAnimation {
                    matchedCards.insert(flippedIndices[0])
                    matchedCards.insert(flippedIndices[1])
                    score += 10
                }
            }
            
            withAnimation {
                flippedCards.removeAll()
            }
        }
    }
}

// MARK: - 记忆卡片数据模型
struct MemoryCard: Identifiable {
    let id = UUID()
    let symbol: String
}

#Preview {
    CardFlipAnimationDemo()
}
