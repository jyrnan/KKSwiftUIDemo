//
//  ScrollTargetBehaviorDemo.swift
//  KKSwiftUIDemo
//
//  Created by jyrnan on 2025/6/7.
//

import SwiftUI

struct ScrollTargetBehaviorDemo: View {
    var body: some View {
        ScrollView {
            ForEach(0..<100) { index in
                
                Text("Hello")
            }
        }
        .scrollTargetBehavior(MyScrollTargetBehavior())
    }
}

#Preview {
    ScrollTargetBehaviorDemo()
}

struct MyScrollTargetBehavior: ScrollTargetBehavior {
    func updateTarget(_ target: inout ScrollTarget, context: TargetContext) {
        print("updateTarget called with target: \(target)")
        print("context: \(context.contentSize)")
    }
    
    }
