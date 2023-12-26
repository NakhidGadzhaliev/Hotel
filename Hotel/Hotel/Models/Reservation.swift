//
//  Reservation.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 15.12.2023.
//

import Foundation

struct Reservation: Decodable {
    let id: Int
    let hotelName, hotelAdress: String
    let horating: Int
    let ratingName, departure, arrivalCountry, tourDateStart: String
    let tourDateStop: String
    let numberOfNights: Int
    let room, nutrition: String
    let tourPrice, fuelCharge, serviceCharge: Int
}
