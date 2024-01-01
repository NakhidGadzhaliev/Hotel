//
//  Image + Assest.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 16.12.2023.
//

import SwiftUI

extension Image {
    init(asset: AssetIdentifier) {
        self.init(asset.rawValue)
    }
}

enum AssetIdentifier: String {
    case closeSquare = "close-square"
    case emojiHappy = "emoji-happy"
    case partyPopper = "party-popper"
    case tickSquare = "tick-square"
}
