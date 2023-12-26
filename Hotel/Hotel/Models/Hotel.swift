//
//  Hotel.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 14.12.2023.
//

import Foundation

struct Hotel: Decodable {
    let id: Int
    let name, adress: String
    let minimalPrice: Int
    let priceForIt: String
    let rating: Int
    let ratingName: String
    let imageUrls: [String]
    let aboutTheHotel: AboutTheHotel
}

struct AboutTheHotel: Decodable {
    let description: String
    let peculiarities: [String]
}
