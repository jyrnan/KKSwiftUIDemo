//
//  ContentView.swift
//  KKSwiftUIDemo
//
//  Created by jyrnan on 2025/3/28.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.appState.number) var number
    var items: [TreeNode] = TreeNode.content
        
    var body: some View {
        NavigationStack {
            List {
                RecursiveTreeView(items: items)
            }
            .navigationDestination(for: NaviDestination.self) { $0 }
            .navigationTitle("SwiftUI Demo!")
        }
        .tint(.red)
    }
}

#Preview {
    ContentView()
}
