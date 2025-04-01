//
//  AppState.swift
//  KKSwiftUIDemo
//
//  Created by jyrnan on 2025/3/31.
//

import SwiftUI



@Observable
class AppState {
    var number: Int = 0
    init() {
        print("AppState init")
    }
    
    func increment() {
        number += 1
    }
}

extension TreeNode {
    static let appState = TreeNode(name: "appState")
}
