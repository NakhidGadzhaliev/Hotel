//
//  RoomViewModel.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 15.12.2023.
//

import SwiftUI
import Combine

final class RoomViewModel: ObservableObject {
    @Published var room: Room = Room(rooms: [])
    @Published var isRequestFailed = true
    @Published var isLoading = false
    @Published var error: Error?
    
    private var cancellables: Set<AnyCancellable> = []
    private let networkManager: NetworkManager
    private let coordinator: RoomCoordinator
    
    init(coordinator: RoomCoordinator, networkManager: NetworkManager) {
        self.coordinator = coordinator
        self.networkManager = networkManager
    }
    
    func openNextScreen() {
        coordinator.openReservationScreen()
    }
    
    func fetchRoom() {
        isLoading = true
        
        networkManager.fetchRooms()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.isLoading = false
                case .failure(let error):
                    self?.isLoading = false
                    self?.error = error
                }
            } receiveValue: { [weak self] room in
                self?.room = room
            }
            .store(in: &cancellables)
    }
}
