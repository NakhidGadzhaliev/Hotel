//
//  Tourist.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 19.12.2023.
//

import Foundation

struct Tourist: Identifiable {
    let id = UUID()
    let number: String
    var name: String
    var lastName: String
    var birthDate: String
    var citizenship: String
    var passportNumber: String
    var passportExpirationDate: String

    func areFieldsValid() -> Bool {
        Validator.isTextValid(name) && Validator.isTextValid(lastName) &&
        Validator.isDateValid(birthDate) && Validator.isTextValid(citizenship) &&
        Validator.isPassportNumberValid(passportNumber) && Validator.isDateValid(passportExpirationDate)
    }
}
