//
//  HotelViewModel.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 14.12.2023.
//

import SwiftUI
import Combine

// ViewModel для отображения данных об отеле
final class HotelViewModel: ObservableObject {
    // Публикуемые свойства для обновления UI
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
    @Published var isRequestFailed = true // Флаг ошибки запроса
    @Published var isLoading = false // Флаг загрузки данных
    @Published var error: Error? // Ошибка запроса
    
    private var cancellables: Set<AnyCancellable> = [] // Содержит все подписки на Combine
    private let coordinator: HotelCoordinator // Координатор для навигации
    private let networkManager: NetworkManager // Менеджер сетевых запросов
    
    // Инициализатор ViewModel
    init(coordinator: HotelCoordinator, networkManager: NetworkManager) {
        self.coordinator = coordinator
        self.networkManager = networkManager
    }
    
    // Открытие экрана с информацией о номерах отеля
    func openRoomScreen(with title: String) {
        coordinator.openRoomScreen(with: title)
    }
    
    // Запрос данных об отеле
    func fetchHotel() {
        isLoading = true // Устанавливаем флаг загрузки в true перед запросом
        
        // Используем NetworkManager для выполнения запроса к серверу
        networkManager.fetchHotel()
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
            } receiveValue: { [weak self] hotel in
                // Обработка полученных данных об отеле
                self?.hotel = hotel
            }
            .store(in: &cancellables) // Сохраняем подписку для управления ею
    }
}
