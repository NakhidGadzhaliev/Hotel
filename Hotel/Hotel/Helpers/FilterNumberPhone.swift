//
//  FilterNumberPhone.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 18.12.2023.
//

import Foundation

final class FilterNumberPhone {
    static func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: String.empty, options: .regularExpression)
        var result = String.empty
        var index = numbers.startIndex
        
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}
