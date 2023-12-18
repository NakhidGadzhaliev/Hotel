//
//  TouristInfoView.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 16.12.2023.
//

import SwiftUI

struct TouristInfoView: View {
    @State private var isExpanded: Bool = false
    @State private var name: String = ""
    @State private var lastName: String = ""
    @State private var birthDate: String = ""
    @State private var citizenship: String = ""
    @State private var passportNumber: String = ""
    @State private var validityPeriod: String = ""
    let validationRule: (_ value: String) -> Bool
    
    let title: String
    
    var body: some View {
        VStack {
            DisclosureGroup(title, isExpanded: $isExpanded) {
                VStack(alignment: .leading, spacing: 8) {
                    BaseTextField(
                        text: name,
                        title: "Имя",
                        validationRule: validationRule
                    )
                    
                    BaseTextField(
                        text: lastName,
                        title: "Фамилия",
                        validationRule: validationRule
                    )
                    
                    DateTextField(
                        title: "Дата рождения",
                        mask: "XX.XX.XXXX"
                    )
                    
                    BaseTextField(
                        text: citizenship,
                        title: "Гражданство",
                        validationRule: validationRule
                    )
                    
                    BaseTextField(
                        text: passportNumber,
                        title: "Номер загранпаспорта",
                        keyboardType: .numberPad,
                        validationRule: validationRule
                    )
                    
                    DateTextField(
                        title: "Срок действия загранпаспорта",
                        mask: "XX.XX.XXXX"
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
                        Image(systemSymbol: .chevronUp)
                            .resizable()
                            .frame(width: 12, height: 6)
                            .foregroundStyle(.customBlue)
                            .onTapGesture {
                                configuration.isExpanded.toggle()
                            }
                    } else {
                        Image(systemSymbol: .chevronDown)
                            .resizable()
                            .frame(width: 12, height: 6)
                            .foregroundStyle(.customBlue)
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

private struct DateTextField: View {
    let title: String
    let mask: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.customGray)
            NumbersBaseTextField(title: title, mask: mask)
        }
        .frame(height: 52)
    }
}
//
//#Preview{
//    TouristInfoView(title: "First")
//}
