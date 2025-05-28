//
//  SearchableView.swift
//  KKSwiftUIDemo
//
//  Created by jyrnan on 2025/5/24.
//

import SwiftUI

struct SearchableView: View {
    @State private var searchText = ""
    @State private var isPresented = false
    var body: some View {
        NavigationStack {
//            List{
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .onTapGesture {
                    isPresented.toggle()
                }
                
//            }
            .navigationTitle("Searchable")
        }
        .searchable(text: $searchText, isPresented: $isPresented)
    }
}

#Preview {
    SearchableView()
}
