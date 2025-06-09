//
//  RestrictedTextField.swift
//  KKSwiftUIDemo
//
//  Created by jyrnan on 2025/6/9.
//

import SwiftUI

struct RestrictedTextField<Content: View>: View {
    var hint:String
    var characters: CharacterSet
    @Binding var value: String
    @ViewBuilder var content: (TextField<Text>, String) -> Content
    @State private var errorMessage: String = ""
    var body: some View {
        content(
            TextField(hint, text: $value),
            errorMessage
        )
        .onChange(of: value) { oldValue, newValue in
            let restrictedCharacters = newValue.unicodeScalars.filter { characters.contains($0) }
            if !restrictedCharacters.isEmpty {
                errorMessage = "\(restrictedCharacters)"
            } else {
                if !oldValue.unicodeScalars.contains(where: {characters.contains($0)}) {
                    errorMessage = ""
                }
            }
        }
    }
}

#Preview {
    NavigationStack{
        RestrictedTextFieldWrapper()
    }
}

struct RestrictedTextFieldWrapper:View {
    @State private var username: String = ""
    var body: some View {
            VStack{
                RestrictedTextField(hint: "i_justine", characters: .alphanumerics.inverted, value: $username) { textField, errorMessage in
                    ZStack(alignment: .bottomLeading) {
                        let isEmpty = errorMessage.isEmpty
                        
                        textField
                            .padding(.horizontal, 15)
                            .padding(.vertical, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(.gray.opacity(0.2))
                            )
                        
                        if !isEmpty {
                            Text("username contains \(errorMessage)")
                                .font(.caption2)
                                .foregroundColor(.gray)
                                .offset(y: 25)
                                .transition(.blurReplace)
                        }
                    }
                }
                .padding(15)
            }
            .navigationTitle("Restricted TextField")
    }
}
