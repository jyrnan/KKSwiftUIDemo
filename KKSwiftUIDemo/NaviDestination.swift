//
//  NaviDestination.swift
//  KKSwiftUIDemo
//
//  Created by jyrnan on 2025/3/31.
//

import SwiftUI

enum NaviDestination: String, CaseIterable, View, Identifiable {
    var id: String {self.rawValue}
    
    case appState
    
    var body: some View {
        switch self {
        case .appState:
            AppStateView()
        }
    }
}
