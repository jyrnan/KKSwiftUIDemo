//
//  Debounce.swift
//  KKSwiftUIDemo
//
//  Created by jyrnan on 2025/4/30.
//

import SwiftUI

struct DebounceSearchView: View {
    @State private var searchText = ""
    @State private var debouncedText = ""
    @State private var textSize = CGSize.zero
    
    var body: some View {
        VStack {
            TextField("Search", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Text("Debounced Text: \(debouncedText)")
                .padding()
                .onGeometryChange(for: CGSize.self) { $0.size} action: {
                    textSize = $0
                }
            Text("Text Size: \(textSize.width) x \(textSize.height)")
                .padding()
                
        }
        .task(id: searchText) {
            if !searchText.isEmpty && searchText.count > 3 {
                
                try? await Task.sleep(nanoseconds: 2_000_000_000)
                
                guard !Task.isCancelled else { return }
                
                await performSearch(searchText)
            }
        }
    }
    private func performSearch(_ newValue: String) async {
//        try? await Task.sleep(nanoseconds: 500_000_000)
        Task { @MainActor in
            debouncedText = "searching for \(newValue)"
        }
    }
}

#Preview {
    DebounceSearchView()
    
}
