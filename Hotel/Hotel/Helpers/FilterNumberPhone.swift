//
//  FilterNumberPhone.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 18.12.2023.
//

import Foundation

// Структура для форматирования номера телефона с учетом заданного паттерна
struct FilterNumberPhone {
    // Метод для применения паттерна на номер телефона
    static func applyPatternOnNumbers(_ stringvar: inout String, pattern: String, replacementCharacter: Character) {
        // Извлекаем только цифры из строки
        var pureNumber = stringvar.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        // Проходим по всем символам в паттерне и вставляем их в номер телефона
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else {
                // Если достигли конца номера, сохраняем его и выходим из цикла
                stringvar = pureNumber
                return
            }
            
            // Получаем индекс в строке паттерна
            let stringIndex = String.Index(utf16Offset: index, in: pattern)
            // Получаем символ из паттерна
            let patternCharacter = pattern[stringIndex]
            
            // Пропускаем символы, которые должны быть заменены
            guard patternCharacter != replacementCharacter else { continue }
            
            // Вставляем символ из паттерна в номер телефона
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        // Сохраняем отформатированный номер телефона
        stringvar = pureNumber
    }
}
