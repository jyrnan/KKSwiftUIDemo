//
//  CustomListContainer.swift
//  KKSwiftUIDemo
//
//  Created by jyrnan on 2025/5/28.
//

import SwiftUI

struct CustomList<Content: View>: View {
    @ViewBuilder var content: Content
    
    var body : some View {
        List {
            
            ForEach(subviews: content) { subView in
                subView
                    .background(subView.containerValues.isHighlied ? Color.yellow : Color.clear)
            }
        }
    }
}


#Preview {
    CustomList {
        Text("Hello, World!")
        Text("Hello, SwiftUI!")
            .isHighlied(true)
        Text("Hello, Custom List!")
    }
}

extension ContainerValues {
    @Entry var isHighlied: Bool = false
}

extension View {
    func isHighlied(_ value: Bool) -> some View {
        self
            .containerValue(\.isHighlied, value)
    }
}
