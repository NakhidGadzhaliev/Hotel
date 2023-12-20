//
//  Validator.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 20.12.2023.
//

import Foundation

struct Validator {
    private enum Constants {
        static let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        static let format = "SELF MATCHES %@"
    }
    
    static func isTextValid(_ value: String) -> Bool {
        let letters = CharacterSet.letters
        let isOnlyLetters = value.rangeOfCharacter(from: letters.inverted) == nil
        return isOnlyLetters && value.count > 2
    }
    
    static func isDateValid(_ value: String) -> Bool {
        return value.count == 10
    }
    
    static func isPassportNumberValid(_ value: String) -> Bool {
        return value.count > 3
    }
    
    static func isEmailValid(_ value: String) -> Bool {
        let emailRegex = Constants.emailRegex
        let emailPredicate = NSPredicate(format: Constants.format, emailRegex)
        return emailPredicate.evaluate(with: value)
    }
    
    static func isPhoneNumberValid(_ value: String) -> Bool {
        return value.count == 18
    }
}
