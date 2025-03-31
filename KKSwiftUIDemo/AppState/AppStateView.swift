//
//  AppStateView.swift
//  KKSwiftUIDemo
//
//  Created by jyrnan on 2025/3/31.
//

import SwiftUI

struct AppStateView: View {
    @Environment(\.appState) var appState
    var body: some View {
        Text("number increased: \(appState.number)")
    }
}

#Preview {
    AppStateView()
}
