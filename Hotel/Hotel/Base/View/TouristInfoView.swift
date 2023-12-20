//
//  TouristInfoView.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 19.12.2023.
//

import SwiftUI

struct TouristInfoView: View {
    private enum Constants {
        static let name = "Имя"
        static let lastName = "Фамилия"
        static let birthDate = "Дата рождения"
        static let dateMask = "XX.XX.XXXX"
        static let citizenship = "Гражданство"
        static let passportNumber = "Номер загранпаспорта"
        static let passportExporationDate = "Срок действия загранпаспорта"
    }
    
    @Binding var tourist: Tourist
    @State private var isExpanded: Bool = false
    
    let title: String
    
    var body: some View {
        VStack {
            DisclosureGroup(tourist.number, isExpanded: $isExpanded) {
                VStack(alignment: .leading, spacing: 8) {
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
                        isValidated: Validator.isDateValid(tourist.birthDate),
                        mask: Constants.dateMask
                    )
                    
                    BaseTextField(
                        text: $tourist.citizenship,
                        isValidated: Validator.isTextValid(tourist.citizenship),
                        title: Constants.citizenship
                    )
                    
                    BaseTextField(
                        text: $tourist.passportNumber,
                        isValidated: Validator.isPassportNumberValid(tourist.passportNumber),
                        title: Constants.passportNumber,
                        keyboardType: .numberPad
                    )
                    
                    DateTextField(
                        text: $tourist.passportExpirationDate,
                        title: Constants.passportExporationDate,
                        isValidated: Validator.isDateValid(tourist.passportExpirationDate),
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

private struct TouristDisclosureStyle: DisclosureGroupStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            HStack {
                configuration.label
                Spacer()
                ZStack {
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
            
            if configuration.isExpanded {
                configuration.content
            }
        }
    }
}

private struct DisclosureIconView: View {
    let image: SFSymbolIdentifier
    
    var body: some View {
        Image(systemSymbol: image)
            .resizable()
            .frame(width: 12, height: 6)
            .foregroundStyle(.customBlue)
    }
}

private struct DateTextField: View {
    @Binding var text: String
    let title: String
    let isValidated: Bool
    let mask: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.customGray)
            BaseNumberField(text: $text, title: title, mask: mask, isValidated: isValidated)
        }
        .frame(height: 52)
    }
}
