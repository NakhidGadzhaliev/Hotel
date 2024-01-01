//
//  Int + WithSeparator.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 02.01.2024.
//

import Foundation

extension Int {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? String.empty
    }
}
