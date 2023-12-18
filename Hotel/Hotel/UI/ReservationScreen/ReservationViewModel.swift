//
//  ReservationViewModel.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 15.12.2023.
//

import SwiftUI
import Combine

final class ReservationViewModel: ObservableObject {
    @Published var reservation = Reservation(
        id: .zero,
        hotelName: "",
        hotelAdress: "",
        horating: .zero,
        ratingName: "",
        departure: "",
        arrivalCountry: "",
        tourDateStart: "",
        tourDateStop: "",
        numberOfNights: .zero,
        room: "",
        nutrition: "",
        tourPrice: .zero,
        fuelCharge: .zero,
        serviceCharge: .zero
    )
    @Published var tourists: [String] = ["Первый турист"]
    @Published var isRequestFailed = true
    @Published var isLoading = false
    @Published var error: Error?
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
        let newElement = numberString(for: tourists.count)
        tourists.append("\(newElement) турист")
    }
    
    func isTextValid(_ value: String) -> Bool {
        return value.count > 1
    }
    
    func isValidEmail(_ value: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: value)
    }
    
    private func numberString(for index: Int) -> String {
        let number = index + 1
        switch number {
        case 1: return "Первый"
        case 2: return "Второй"
        case 3: return "Третий"
        case 4: return "Четвертый"
        case 5: return "Пятый"
        default: return "\(number)-й"
        }
    }
}
