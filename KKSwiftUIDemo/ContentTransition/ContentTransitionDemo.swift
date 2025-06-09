//
//  ContentTransitionDemo.swift
//  KKSwiftUIDemo
//
//  Created by jyrnan on 2025/5/2.
//

import SwiftUI

struct ContentTransitionDemo: View {
    @State private var isTriggered = false
    @State private var number = 99
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .foregroundStyle(isTriggered ? .red : .blue)
                .contentTransition(.interpolate)
                .animation(.easeInOut, value: isTriggered)
                .onTapGesture {
                    isTriggered.toggle()
                }
            
            Text("\(number)")
                .foregroundStyle(isTriggered ? .red : .blue)
                .contentTransition(.numericText())
                .animation(.easeInOut, value: number)
                .onTapGesture {
                    number += 1
                }
            Divider()
            CurrencyView()
        }
    }
}

struct CurrencyView: View {
    @State private var value: Double = 0
    private var currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        return formatter
    }()
    var body: some View {
        VStack {
            Text("\(currencyFormatter.string(from: value as NSNumber)!)")
                .font(.largeTitle)
                .bold()
                .contentTransition(.numericText(value: value))
            Button("Increment") {
                withAnimation { value += 111 }
            }
        }
    }
}

#Preview {
    ContentTransitionDemo()
}
