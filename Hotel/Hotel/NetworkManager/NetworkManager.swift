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
    private let decoder = JSONDecoder()
    
    func fetchHotel() -> AnyPublisher<Hotel, Error> {
        fetchData(
            url: Constants.hotelUrl,
            type: Hotel.self
        )
    }
    
    func fetchRooms() -> AnyPublisher<Room, Error> {
        fetchData(
            url: Constants.roomUrl,
            type: Room.self
        )
    }
    
    func fetchReservation() -> AnyPublisher<Reservation, Error> {
        fetchData(
            url: Constants.reservationUrl,
            type: Reservation.self
        )
    }
    
    private func fetchData<T: Decodable>(url: String, type: T.Type) -> AnyPublisher<T, Error> {
        guard let url = URL(string: url) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: type.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
