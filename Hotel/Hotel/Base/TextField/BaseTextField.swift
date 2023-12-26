//
//  BaseTextField.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 15.12.2023.
//

import SwiftUI

struct BaseTextField: View {
    @FocusState var isFocused: Bool
    @Binding var text: String
    @State private var color: Color = .customGray
    
    let isValidated: Bool
    let title: String
    var keyboardType: UIKeyboardType = .alphabet
    var capitalization: TextInputAutocapitalization = .words
    var maxLength: Int = 100
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(color)
            VStack(spacing: 0) {
                if text.isEmpty {
                    if isFocused {
                        TextFieldTitleView(title: title)
                            .font(Font.Default.d12)
                    } else {
                        TextFieldTitleView(title: title)
                            .font(Font.Default.d17)
                            .offset(CGSize(width: 0, height: 10))
                    }
                } else {
                    TextFieldTitleView(title: title)
                        .font(Font.Default.d12)
                }
                TextField(String.empty, text: $text.maxLength(maxLength))
                    .font(Font.Default.d17)
                    .focused($isFocused)
                    .keyboardType(keyboardType)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(capitalization)
                    .onChange(of: text) {
                        if text.count <= maxLength {
                            color = isValidated ? Color.customGray : Color(hex: "#EB5757").opacity(0.15)
                        }
                    }
            }
            .padding(.horizontal, 16)
        }
        .frame(height: 52)
    }
}

private struct TextFieldTitleView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .foregroundStyle(.customDarkGray)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
