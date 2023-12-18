//
//  Font + Typography.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 16.12.2023.
//

import SwiftUI

extension Font {
    enum Medium {
        static let m14 = Font.system(size: 14, weight: .medium)
        static let m16 = Font.system(size: 16, weight: .medium)
        static let m22 = Font.system(size: 22, weight: .medium)
    }
    
    enum Semibold {
        static let s16 = Font.system(size: 16, weight: .semibold)
        static let s30 = Font.system(size: 30, weight: .semibold)
    }
    
    enum Default {
        static let d12 = Font.system(size: 12)
        static let d16 = Font.system(size: 16)
        static let d17 = Font.system(size: 17)
    }
}
