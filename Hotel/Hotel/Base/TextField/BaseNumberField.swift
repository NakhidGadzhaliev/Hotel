//
//  BaseNumberField.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 18.12.2023.
//

import SwiftUI

struct BaseNumberField: View {
    @Binding var text: String
    @State private var color: Color = .customGray
    
    let title: String
    let mask: String
    let isValidated: Bool
    
    var body: some View {
        let textChangedBinding = Binding<String>(
            get: {
                FilterNumberPhone.format(with: self.mask, phone: self.text)},
            set: { self.text = $0
            })
        
        TextFieldContainer(title, text: textChangedBinding)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(color)
            )
            .onChange(of: text) {
                color = isValidated ? Color.customGray : Color(hex: "#EB5757").opacity(0.15)
            }
    }
}

private struct TextFieldContainer: UIViewRepresentable {
    private let placeholderAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor.customDarkGray,
        .font: UIFont.systemFont(ofSize: 17)
    ]
    private var placeholder: String
    private var text: Binding<String>
    
    init(_ placeholder:String, text: Binding<String>) {
        self.placeholder = placeholder
        self.text = text
    }
    
    func makeCoordinator() -> TextFieldContainer.Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<TextFieldContainer>) -> UITextField {
        let innertTextField = UITextField(frame: .zero)
        innertTextField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: placeholderAttributes
        )
        innertTextField.text = text.wrappedValue
        innertTextField.delegate = context.coordinator
        innertTextField.keyboardType = .numberPad
        
        context.coordinator.setup(innertTextField)
        
        return innertTextField
    }
    
    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<TextFieldContainer>) {
        uiView.text = self.text.wrappedValue
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: TextFieldContainer
        
        init(_ textFieldContainer: TextFieldContainer) {
            self.parent = textFieldContainer
        }
        
        func setup(_ textField:UITextField) {
            textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
        
        @objc func textFieldDidChange(_ textField: UITextField) {
            self.parent.text.wrappedValue = textField.text ?? .empty
            
            let newPosition = textField.endOfDocument
            textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
        }
    }
}
