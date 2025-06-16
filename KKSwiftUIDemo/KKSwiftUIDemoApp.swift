//
//  KKSwiftUIDemoApp.swift
//  KKSwiftUIDemo
//
//  Created by jyrnan on 2025/3/28.
//

import SwiftUI

@main
struct KKSwiftUIDemoApp: App {
    @Environment(\.scenePhase) var scenePhase
    @State var appState = AppState()
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environment(\.appState, appState)
        .onChange(of: scenePhase) { oldValue, newValue in
            switch newValue {
            case .active:
                print("App is active")
                appState.increment()
            default:
                break
            }
        }
    }
}
