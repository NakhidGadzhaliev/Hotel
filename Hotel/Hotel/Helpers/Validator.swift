//
//  Validator.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 20.12.2023.
//

import Foundation

// Структура Validator для проверки валидности различных типов данных
struct Validator {
    // Проверка валидности текстового значения
    static func isTextValid(_ value: String) -> Bool {
        // Проверяем, что значение состоит только из букв и имеет длину более 2 символов
        let letters = CharacterSet.letters
        let isOnlyLetters = value.rangeOfCharacter(from: letters.inverted) == nil
        return isOnlyLetters && value.count > 2
    }
    
    // Проверка валидности даты
    static func isDateValid(_ value: String) -> Bool {
        // Проверяем, что дата имеет заданную длину
        return value.count == Constants.dateMaskCount
    }
    
    // Проверка валидности номера паспорта
    static func isPassportNumberValid(_ value: String) -> Bool {
        // Проверяем, что номер паспорта имеет длину более 3 символов
        return value.count > 3
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
