//
//  DateFormatter + Custom.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 27.12.2023.
//

import Foundation

extension DateFormatter {
    static let customDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
}
