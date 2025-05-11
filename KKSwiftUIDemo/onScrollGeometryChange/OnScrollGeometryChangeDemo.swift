//
//  OnScrollGeometryChangeDemo.swift
//  KKSwiftUIDemo
//
//  Created by jyrnan on 2025/5/3.
//

import SwiftUI

struct OnScrollGeometryChangeDemo: View {
    @State private var scrollGeometry: ScrollGeometry = .init(contentOffset: .zero, contentSize: .zero, contentInsets: .init(), containerSize: .zero)
    var body: some View {
        NavigationStack{
            
            ScrollView{
                Text("Hello, World!")
                    .frame(maxWidth: .infinity)
                    .border(.red)
                
            }
            .onScrollGeometryChange(for: ScrollGeometry.self){
                $0
            }action: { oldValue, newValue in
                scrollGeometry = newValue
            }
            .border(.red)
            .overlay(alignment: .bottom) {
                Text(scrollGeometry.debugDescription)
                
                    .padding()
            }
        }
    }
}

#Preview {
    OnScrollGeometryChangeDemo()
}
