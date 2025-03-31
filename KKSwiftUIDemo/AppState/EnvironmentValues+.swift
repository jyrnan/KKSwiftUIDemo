//
//  EnvironmentValues+.swift
//  KKSwiftUIDemo
//
//  Created by jyrnan on 2025/3/31.
//

import SwiftUI
// 通过这个方法可以创建一个新的EnvironmentValue
// 但是如果需要保证这个值是唯一的，仍然需要通过在视图顶层主动创建值
// 并注入视图层级中，如：KKSwiftUIDemoApp.swift:13
extension EnvironmentValues {
    @Entry var appState: AppState = .init()
}
