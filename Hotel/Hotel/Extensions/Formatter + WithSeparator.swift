//
//  Formatter + WithSeparator.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 02.01.2024.
//

import Foundation

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = String.space
        formatter.numberStyle = .decimal
        return formatter
    }()
}
