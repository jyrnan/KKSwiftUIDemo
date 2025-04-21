//
//  NaviDestination.swift
//  KKSwiftUIDemo
//
//  Created by jyrnan on 2025/3/31.
//

// updae for xcode cloud
import SwiftUI

enum NaviDestination: String, CaseIterable, View, Identifiable {
    var id: String { self.rawValue }

    case appState
    case transition
    case text1

    var body: some View {
        switch self {
        case .appState:
            AppStateView()
        case .transition:
            TransitionTab()
        case .text1:
            Text("Item 1")
        }
    }
}
