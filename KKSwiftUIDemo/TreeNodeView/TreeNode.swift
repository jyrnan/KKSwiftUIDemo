//
//  TreeNode.swift
//  KKSwiftUIDemo
//
//  Created by jyrnan on 2025/4/1.
//
import SwiftUI

struct TreeNode: Identifiable, View {
    let id = UUID()
    let name: String
    var children: [TreeNode] = []
    var isExpanded: Bool = false

    var body: some View {
        Text(name)
            .foregroundStyle(children.isEmpty ? .blue : .primary)
            .bold(!children.isEmpty)
            .scaleEffect(isExpanded ? 1.2 : 1)
    }
}

extension TreeNode {
    static var content: [TreeNode] {
        [
            .appState,
            .transition,
            .text
        ]
    }

    static var text: TreeNode = .init( name: "text", children: [
        .init(name: "text1"),
        .init(name: "text2"),
        .init(name: "text3")
    ])
        
}

extension TreeNode {
    static var samples: [TreeNode] {
        [
            TreeNode(name: "Item 1"),
            TreeNode(name: "Item 2", children: [
                TreeNode(name: "Item 2.1"),
                TreeNode(name: "Item 2.2", children: [
                    TreeNode(name: "Item 2.2.1"),
                    TreeNode(name: "Item 2.2.2")
                ])
            ]),
            TreeNode(name: "Item 3")
        ]
    }
}
