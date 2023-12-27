//
//  Validator.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 20.12.2023.
//

import Foundation

// Структура Validator для проверки валидности различных типов данных
struct Validator {
    private static let currentDate = Date()
    private static let calendar = Calendar.current
    // Проверка валидности текстового значения
    static func isTextValid(_ value: String) -> Bool {
        // Проверяем, что значение состоит только из букв и имеет длину более 2 символов
        let letters = CharacterSet.letters
        let isOnlyLetters = value.rangeOfCharacter(from: letters.inverted) == nil
        return isOnlyLetters && value.count > 2
    }
    // Проверяем, валидны ли данные о дате рождения
    static func isBirthDateValid(_ date: String) -> Bool {
        guard let enteredDate = DateFormatter.customDateFormatter.date(from: date) else {
            return false
        }
        
        let minimumAllowedDate = calendar.date(byAdding: .year, value: -90, to: currentDate)
        let maximumAllowedDate = calendar.date(byAdding: .year, value: -18, to: currentDate)
        
        guard let minDate = minimumAllowedDate,
              let maxDate = maximumAllowedDate else {
            return false
        }
        
        return enteredDate >= minDate && enteredDate <= maxDate
    }
    
    // Проверяем, валидны ли данные о дате истечения срока паспорта
    static func isExpirationDateValid(_ date: String) -> Bool {
        guard let enteredDate = DateFormatter.customDateFormatter.date(from: date) else {
            return false
        }
        
        let minimumAllowedDate = calendar.date(byAdding: .month, value: +6, to: currentDate)
        let maximumAllowedDate = calendar.date(byAdding: .year, value: +20, to: currentDate)
        
        guard let minDate = minimumAllowedDate,
              let maxDate = maximumAllowedDate else {
            return false
        }
        
        return enteredDate >= minDate && enteredDate <= maxDate
    }
    
    // Проверка валидности номера паспорта
    static func isPassportNumberValid(_ value: String) -> Bool {
        // Проверяем, что номер паспорта имеет длину более 3 символов
        return value.count == 10
    }
    
    // Проверка валидности электронной почты
    static func isEmailValid(_ value: String) -> Bool {
        // Используем регулярное выражение для проверки формата электронной почты
        let emailRegex = Constants.emailRegex
        let emailPredicate = NSPredicate(format: Constants.format, emailRegex)
        return emailPredicate.evaluate(with: value)
    }
    
    // Проверка валидности номера телефона
    static func isPhoneNumberValid(_ value: String) -> Bool {
        // Проверяем, что номер телефона имеет заданную длину
        return value.count == Constants.phoneNumberMaskCount
    }
}
