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
        isTextValid(name) && isTextValid(lastName) && isTextValid(name) && isDateValid(birthDate) &&
        isTextValid(citizenship) && isNumberValid(passportNumber) && isDateValid(passportExpirationDate)
    }
    
    private func isTextValid(_ value: String) -> Bool {
        return value.count > 2
    }
    
    private func isDateValid(_ value: String) -> Bool {
        return value.count == 10
    }
    
    private func isNumberValid(_ value: String) -> Bool {
        return value.count > 3
    }
}
