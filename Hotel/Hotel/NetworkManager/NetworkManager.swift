//
//  NetworkManager.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 16.12.2023.
//

import Foundation
import Combine

private enum NetworkError: Error {
    case invalidURL
}

final class NetworkManager {
    private enum Constant {
        static let hotelUrl = "https://run.mocky.io/v3/d144777c-a67f-4e35-867a-cacc3b827473"
        static let roomUrl = "https://run.mocky.io/v3/8b532701-709e-4194-a41c-1a903af00195"
        static let reservationUrl = "https://run.mocky.io/v3/63866c74-d593-432c-af8e-f279d1a8d2ff"
    }
    func fetchHotel() -> AnyPublisher<Hotel, Error> {
        fetchData(
            url: Constant.hotelUrl,
            type: Hotel.self
        )
    }
    
    func fetchRooms() -> AnyPublisher<Room, Error> {
        fetchData(
            url: Constant.roomUrl,
            type: Room.self
        )
    }
    
    func fetchReservation() -> AnyPublisher<Reservation, Error> {
        fetchData(
            url: Constant.reservationUrl,
            type: Reservation.self
        )
    }
    
    private func fetchData<T: Decodable>(url: String, type: T.Type) -> AnyPublisher<T, Error> {
        guard let url = URL(string: url) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: type.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
