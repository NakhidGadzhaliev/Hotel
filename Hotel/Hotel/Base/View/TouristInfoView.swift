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
                    
                    BaseNumberField(
                        number: $tourist.birthDate,
                        title: Constants.birthDate,
                        mask: Constants.dateMask,
                        isNumberValidated: Validator.isBirthDateValid(tourist.birthDate)
                    )
                    
                    BaseTextField(
                        text: $tourist.citizenship,
                        isValidated: Validator.isTextValid(tourist.citizenship),
                        title: Constants.citizenship
                    )
                    
                    BaseNumberField(
                        number: $tourist.passportNumber,
                        title: Constants.passportNumber,
                        mask: Constants.passportNumberMask,
                        isNumberValidated: Validator.isPassportNumberValid(tourist.passportNumber)
                    )
                    
                    BaseNumberField(
                        number: $tourist.passportExpirationDate,
                        title: Constants.passportExpirationDate,
                        mask: Constants.dateMask,
                        isNumberValidated: Validator.isExpirationDateValid(tourist.passportExpirationDate)
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
                DisclosureIconView(
                    isButtonTapped: configuration.$isExpanded,
                    image: configuration.isExpanded ? .chevronUp : .chevronDown
                )
            }
            
            // Дополнительные данные при раскрытии
            if configuration.isExpanded {
                configuration.content
            }
        }
    }
}

// Иконка для открытия/закрытия
private struct DisclosureIconView: View {
    @Binding var isButtonTapped: Bool
    let image: SFSymbolIdentifier
    
    var body: some View {
        Button {
            isButtonTapped.toggle()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .frame(width: 32, height: 32)
                    .foregroundStyle(.customLightBlue)
                
                Image(systemSymbol: image)
                    .resizable()
                    .frame(width: 12, height: 6)
                    .foregroundStyle(.customBlue)
            }
        }
    }
}
