//
//  TabViewMinimize.swift
//  KKSwiftUIDemo
//
//  Created by jyrnan on 2025/6/20.
//

import SwiftUI

struct TabViewMinimize: View {
    var body: some View {
        TabView {
            
            Tab("Tab 1", systemImage: "house") {
                ExampleView()
            }
            Tab("Tab 2", systemImage: "book") {
                ExampleView()
            }
            Tab("Tab 3", systemImage: "folder") {
                ExampleView()
            }
        }
    }
}

#Preview {
    TabViewMinimize()
}

struct ExampleView: View {
    var body: some View {
        Text("Example View")
    }
}
