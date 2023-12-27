//
//  TouristInfoView.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 19.12.2023.
//

import SwiftUI

// Отображение информации о туристе с возможностью раскрытия дополнительных данных
struct TouristInfoView: View {
    @Binding var tourist: Tourist
    @State private var isExpanded: Bool = false
    
    let title: String
    
    var body: some View {
        VStack {
            // DisclosureGroup для отображения информации о туристе
            DisclosureGroup(tourist.number, isExpanded: $isExpanded) {
                VStack(alignment: .leading, spacing: 8) {
                    // Поля для ввода информации о туристе
                    BaseTextField(
                        text: $tourist.name,
                        isValidated: Validator.isTextValid(tourist.name),
                        title: Constants.name
                    )
                    
                    BaseTextField(
                        text: $tourist.lastName,
                        isValidated: Validator.isTextValid(tourist.lastName),
                        title: Constants.lastName
                    )
                    
                    DateTextField(
                        text: $tourist.birthDate,
                        title: Constants.birthDate,
                        isValidated: Validator.isBirthDateValid(tourist.birthDate),
                        mask: Constants.dateMask
                    )
                    
                    BaseTextField(
                        text: $tourist.citizenship,
                        isValidated: Validator.isTextValid(tourist.citizenship),
                        title: Constants.citizenship
                    )
                    
                    BaseTextField(
                        text: $tourist.passportNumber.maxLength(12),
                        isValidated: Validator.isPassportNumberValid(tourist.passportNumber),
                        title: Constants.passportNumber,
                        keyboardType: .numberPad
                    )
                    
                    DateTextField(
                        text: $tourist.passportExpirationDate,
                        title: Constants.passportExporationDate,
                        isValidated: Validator.isExpirationDateValid(tourist.passportExpirationDate),
                        mask: Constants.dateMask
                    )
                }
            }
            .disclosureGroupStyle(TouristDisclosureStyle())
            .font(Font.Medium.m22)
            .tint(.black)
        }
    }
}

// Стиль для DisclosureGroup
private struct TouristDisclosureStyle: DisclosureGroupStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            HStack {
                // Заголовок
                configuration.label
                Spacer()
                ZStack {
                    // Иконка открытия/закрытия
                    RoundedRectangle(cornerRadius: 6)
                        .frame(width: 32, height: 32)
                        .foregroundStyle(.customLightBlue)
                    if configuration.isExpanded {
                        DisclosureIconView(image: .chevronUp)
                            .onTapGesture {
                                configuration.isExpanded.toggle()
                            }
                    } else {
                        DisclosureIconView(image: .chevronDown)
                            .onTapGesture {
                                configuration.isExpanded.toggle()
                            }
                    }
                }
            }
            
            // Дополнительные данные при раскрытии
            if configuration.isExpanded {
                configuration.content
            }
        }
    }
}

// Поле для ввода даты с маской
private struct DateTextField: View {
    @Binding var text: String
    let title: String
    let isValidated: Bool
    let mask: String
    
    var body: some View {
        BaseNumberField(number: $text, title: title, mask: mask, isNumberValidated: isValidated)
    }
}

// Иконка для открытия/закрытия
private struct DisclosureIconView: View {
    let image: SFSymbolIdentifier
    
    var body: some View {
        Image(systemSymbol: image)
            .resizable()
            .frame(width: 12, height: 6)
            .foregroundStyle(.customBlue)
    }
}
