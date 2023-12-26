//
//  BaseNumberField.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 26.12.2023.
//

import SwiftUI

struct BaseNumberField: View {
    @Binding var number: String
    let title: String
    let mask: String
    let isNumberValidated: Bool
    var maxLength: Int = Constants.dateMaskCount
    
    var body: some View {
        BaseTextField(
            text: $number,
            isValidated: isNumberValidated,
            title: title,
            keyboardType: .numberPad,
            maxLength: maxLength
        )
        .onChange(of: number) {
            FilterNumberPhone.applyPatternOnNumbers(
                &number,
                pattern: mask,
                replacementCharacter: Character(String.x)
            )
        }
    }
}
