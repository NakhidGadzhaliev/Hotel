//
//  HotelFactory.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 14.12.2023.
//

import UIKit

final class HotelFactory {
    static func createHotelController() -> HotelController {
        let coordinator = HotelCoordinator()
        let networkManager = NetworkManager()
        let viewModel = HotelViewModel(coordinator: coordinator, networkManager: networkManager)
        let controller = HotelController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
