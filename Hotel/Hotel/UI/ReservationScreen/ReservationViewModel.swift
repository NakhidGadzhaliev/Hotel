//
//  ReservationViewModel.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 15.12.2023.
//

import SwiftUI
import Combine

final class ReservationViewModel: ObservableObject {
    private enum Constants {
        static let firstTourist = "Первый турист"
        static let tourist = "турист"
        static let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        static let format = "SELF MATCHES %@"
        static let first = "Первый"
        static let second = "Второй"
        static let third = "Третий"
        static let fourth = "Четвертый"
        static let fifth = "Пятый"
    }
    
    @Published var reservation = Reservation(
        id: .zero,
        hotelName: .empty,
        hotelAdress: .empty,
        horating: .zero,
        ratingName: .empty,
        departure: .empty,
        arrivalCountry: .empty,
        tourDateStart: .empty,
        tourDateStop: .empty,
        numberOfNights: .zero,
        room: .empty,
        nutrition: .empty,
        tourPrice: .zero,
        fuelCharge: .zero,
        serviceCharge: .zero
    )
    @Published var tourists: [Tourist] = [
        Tourist(
            number: Constants.firstTourist,
            name: .empty,
            lastName: .empty,
            birthDate: .empty,
            citizenship: .empty,
            passportNumber: .empty,
            passportExpirationDate: .empty
        )
    ]
    @Published var isRequestFailed = true
    @Published var isLoading = false
    @Published var error: Error?
    @Published var areAllFieldsValid: Bool = false
    
    private var cancellables: Set<AnyCancellable> = []
    private let coordinator: ReservationCoordinator
    private let networkManager: NetworkManager
    
    init(coordinator: ReservationCoordinator, networkManager: NetworkManager) {
        self.coordinator = coordinator
        self.networkManager = networkManager
    }
    
    func openSuccessScreen() {
        coordinator.openSuccessScreen()
    }
    
    func fetchReservation() {
        isLoading = true
        
        networkManager.fetchReservation()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.isLoading = false
                case .failure(let error):
                    self?.isLoading = false
                    self?.error = error
                }
            } receiveValue: { [weak self] reservation in
                self?.reservation = reservation
            }
            .store(in: &cancellables)
    }
    
    func addTourist() {
        let newElement = Tourist(
            number: "\(numberString(for: tourists.count)) турист",
            name: .empty,
            lastName: .empty,
            birthDate: .empty,
            citizenship: .empty,
            passportNumber: .empty,
            passportExpirationDate: .empty
        )
        tourists.append(newElement)
    }
    
    func isEmailValid(_ value: String) -> Bool {
        Validator.isEmailValid(value)
    }
    
    func isPhoneNumberValid(_ value: String) -> Bool {
        Validator.isPhoneNumberValid(value)
    }
    
    private func numberString(for index: Int) -> String {
        let number = index + 1
        switch number {
        case 1: return Constants.first
        case 2: return Constants.second
        case 3: return Constants.third
        case 4: return Constants.fourth
        case 5: return Constants.fifth
        default: return "\(number)-й"
        }
    }
}
