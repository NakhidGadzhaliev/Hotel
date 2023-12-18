//
//  HotelViewModel.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 14.12.2023.
//

import SwiftUI
import Combine

final class HotelViewModel: ObservableObject {
    @Published var hotel = Hotel(
        id: .zero,
        name: .empty,
        adress: .empty,
        minimalPrice: .zero,
        priceForIt: .empty,
        rating: .zero,
        ratingName: .empty,
        imageUrls: [],
        aboutTheHotel: AboutTheHotel(description: .empty, peculiarities: [])
    )
    @Published var isRequestFailed = true
    @Published var isLoading = false
    @Published var error: Error?
    
    private var cancellables: Set<AnyCancellable> = []
    private let coordinator: HotelCoordinator
    private let networkManager: NetworkManager
    
    init(coordinator: HotelCoordinator, networkManager: NetworkManager) {
        self.coordinator = coordinator
        self.networkManager = networkManager
    }
    
    func openRoomScreen(with title: String) {
        coordinator.openRoomScreen(with: title)
    }
    
    func fetchHotel() {
        isLoading = true
        
        networkManager.fetchHotel()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.isLoading = false
                case .failure(let error):
                    self?.isLoading = false
                    self?.error = error
                }
            } receiveValue: { [weak self] hotel in
                self?.hotel = hotel
            }
            .store(in: &cancellables)
    }
}
