//
//  ContentView.swift
//  KKSwiftUIDemo
//
//  Created by jyrnan on 2025/3/28.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.appState.number) var number
    var body: some View {
        NavigationStack {
            List{
                    ForEach(NaviDestination.allCases) { destination in
                        NavigationLink(value: destination) {
                            Text(destination.rawValue)
                        }
                    }
            }
            .navigationDestination(for: NaviDestination.self, destination: { $0})
            .navigationTitle("SwiftUI Demo!")
        }
    }
}

#Preview {
    ContentView()
}
