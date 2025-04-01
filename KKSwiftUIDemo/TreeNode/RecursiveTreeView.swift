//
//  RecursiveTreeView.swift
//  KKSwiftUIDemo
//
//  Created by jyrnan on 2025/4/1.
//

import SwiftUI

struct RecursiveTreeView: View {
    @State var items: [TreeNode]
    let level: Int

    init(items: [TreeNode], level: Int = 0) {
        self._items = State(wrappedValue: items)
        self.level = level
    }

    var body: some View {
        ForEach(items) { item in
            if !item.children.isEmpty {
                DisclosureGroup(
                    isExpanded: Binding(
                        get: { item.isExpanded },
                        set: { newValue in
                            if let index = items.firstIndex(where: { $0.id == item.id }) {
                                items[index].isExpanded = newValue
                            }
                        }
                    ),
                    content: {
                        RecursiveTreeView(items: item.children, level: level + 1)
                    }, label: {
                        item
                    }
                )
            } else {
                NavigationLink(value: NaviDestination(rawValue: item.name)) {
                    item
                }
            }
        }
    }
}

#Preview(body: {
    NavigationStack {
        List {
            RecursiveTreeView(items: TreeNode.samples)
        }
        .navigationDestination(for: NaviDestination.self) { $0 }
    }
})
