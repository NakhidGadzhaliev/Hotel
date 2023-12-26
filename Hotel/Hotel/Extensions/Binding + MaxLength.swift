//
//  Binding + MaxLength.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 26.12.2023.
//

import SwiftUI

extension Binding where Value == String {
    func maxLength(_ limit: Int) -> Self {
        if self.wrappedValue.count > limit {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.dropLast())
            }
        }
        return self
    }
}
