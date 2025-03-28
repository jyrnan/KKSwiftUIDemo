//
//  ContentView.swift
//  KKSwiftUIDemo
//
//  Created by jyrnan on 2025/3/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("welcome!")
            }
            .padding()
            .navigationTitle("SwiftUI Demo!")
        }
    }
}

#Preview {
    ContentView()
}
