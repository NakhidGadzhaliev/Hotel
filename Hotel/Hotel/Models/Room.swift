//
//  Room.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 15.12.2023.
//

import Foundation

struct Room: Decodable {
    let rooms: [RoomElement]
}

struct RoomElement: Decodable {
    let id: Int
    let name: String
    let price: Int
    let pricePer: String
    let peculiarities: [String]
    let imageUrls: [String]
}
