//
//  ReservationViewModel.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 15.12.2023.
//

import SwiftUI
import Combine

// ViewModel для экрана оформления бронирования
final class ReservationViewModel: ObservableObject {
    // Опубликованные свойства для обновления интерфейса
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
    
    // Инициализатор класса
    init(coordinator: ReservationCoordinator, networkManager: NetworkManager) {
        self.coordinator = coordinator
        self.networkManager = networkManager
    }
    
    // Метод для открытия экрана успешного бронирования
    func openSuccessScreen() {
        coordinator.openSuccessScreen()
    }
    
    // Метод для загрузки данных о бронировании
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
    
    // Метод для добавления нового туриста
    func addTourist() {
        let newElement = Tourist(
            number: "\(numberString(for: tourists.count)) \(Constants.tourist)",
            name: .empty,
            lastName: .empty,
            birthDate: .empty,
            citizenship: .empty,
            passportNumber: .empty,
            passportExpirationDate: .empty
        )
        tourists.append(newElement)
    }
    
    // Метод для проверки валидности email
    func isEmailValid(_ value: String) -> Bool {
        Validator.isEmailValid(value)
    }
    
    // Метод для проверки валидности номера телефона
    func isPhoneNumberValid(_ value: String) -> Bool {
        Validator.isPhoneNumberValid(value)
    }
    
    // Метод для формирования строки с порядковым номером туриста
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
