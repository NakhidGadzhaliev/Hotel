//
//  Image + SystemImage.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 16.12.2023.
//

import SwiftUI

extension Image {
    init(systemSymbol: SFSymbolIdentifier) {
        self.init(systemName: systemSymbol.rawValue)
    }
}

enum SFSymbolIdentifier: String {
    case photo = "photo"
    case starFill = "star.fill"
    case chevronUp = "chevron.up"
    case chevronDown = "chevron.down"
    case chevronRight = "chevron.right"
    case plus = "plus"
    case networkSlash = "network.slash"
}
