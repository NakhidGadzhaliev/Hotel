//
//  BaseTextField.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 15.12.2023.
//

import SwiftUI

struct BaseTextField: View {
    @Binding var text: String
    @FocusState var isFocused: Bool
    @State var isValidValue: Bool = true
    
    let validationRule: (_ value: String) -> Bool
    let title: String
    var keyboardType: UIKeyboardType = .default
    var capitalization: TextInputAutocapitalization = .words
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(isValidValue ? Color.clear : Color.red)
                .background(.customGray)
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
                TextField(String.empty, text: $text)
                    .font(Font.Default.d17)
                    .focused($isFocused)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(capitalization)
                    .onChange(of: text, perform: { newValue in
                        isValidValue = validationRule(newValue)
                    })
            }
            .padding(.horizontal, 16)
        }
        .frame(height: 52)
        .clipShape(RoundedRectangle(cornerRadius: 10))
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
