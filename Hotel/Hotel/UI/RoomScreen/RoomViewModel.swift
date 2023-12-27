//
//  RoomViewModel.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 15.12.2023.
//

import SwiftUI
import Combine

// ViewModel для отображения данных о номерах в отеле
final class RoomViewModel: ObservableObject {
    // Публикуемые свойства для обновления UI
    @Published var room: Room = Room(rooms: []) // Информация о номерах в отеле
    @Published var isRequestFailed = true // Флаг ошибки запроса
    @Published var isLoading = false // Флаг загрузки данных
    @Published var error: Error? // Ошибка запроса
    
    private var cancellables: Set<AnyCancellable> = [] // Содержит все подписки на Combine
    private let networkManager: NetworkManager // Менеджер сетевых запросов
    private let coordinator: RoomCoordinator // Координатор для навигации
    
    // Инициализатор ViewModel
    init(coordinator: RoomCoordinator, networkManager: NetworkManager) {
        self.coordinator = coordinator
        self.networkManager = networkManager
    }
    
    // Открытие экрана с информацией о бронировании
    func openNextScreen() {
        coordinator.openReservationScreen()
    }
    
    // Запрос данных о номерах в отеле
    func fetchRoom() {
        isLoading = true // Устанавливаем флаг загрузки в true перед запросом
        
        // Используем NetworkManager для выполнения запроса к серверу
        networkManager.fetchRooms()
            .receive(on: DispatchQueue.main) // Переключаемся на главную очередь для обновления UI
            .sink { [weak self] completion in
                // Обработка завершения запроса
                switch completion {
                case .finished:
                    // Устанавливаем флаг загрузки в false при успешном завершении
                    self?.isLoading = false
                case .failure(let error):
                    // Устанавливаем флаг загрузки в false и сохраняем ошибку при неудачном завершении
                    self?.isLoading = false
                    self?.error = error
                }
            } receiveValue: { [weak self] room in
                // Обработка полученных данных о номерах
                self?.room = room
            }
            .store(in: &cancellables) // Сохраняем подписку для управления ей
    }
}
