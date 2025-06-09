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
            .offset(x: isExpanded ? 10 : 0)
    }
}

extension TreeNode {
    static var content: [TreeNode] {
        [
            .StateManagement,
            .Animation,
            .ScrollView,
            .TextSample,
            .ViewManagement,
            .OtherDemo
        ]
    }

    static var StateManagement: TreeNode = .init(name: "State Management", children: [
        .appState,
        .init(name: "containerValues"),
        .init(name: "Debounce")
    ])
    
    static var Animation: TreeNode = .init(name: "Animation", children: [
        .transition,
        .init(name: "ContentTransition"),
        .init(name: "KeyFrameAnimator"),
        .init(name: "ShakeEffect"),
        .init(name: "PhaseAnimator")
            
    ])
    
    static var ScrollView: TreeNode = .init(name: "ScrollView", children: [
        .init(name: "complexScrollAnimation"),
        .init(name: "onScrollGeometryChange"),
        .init(name: "ScrollTargetBehavior")
    ])
    
    static var TextSample: TreeNode = .init(name: "Text", children: [
        .init(name: "RestrictedTextField"),
        .init(name: "StringFormat")
    
    ])
    static var ViewManagement: TreeNode = .init(name: "View Management", children: [
        .init(name: "FullScreenCover"),
        .init(name: "MapMask"),
        .init(name: "position"),
        .init(name: "splitView")
    ])
    
    static var OtherDemo: TreeNode = .init(name: "Other Demo", children: [
        .init(name: "WeekCalendar")
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
