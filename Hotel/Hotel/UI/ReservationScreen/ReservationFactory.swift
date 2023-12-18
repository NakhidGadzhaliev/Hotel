//
//  ReservationFactory.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 15.12.2023.
//

import UIKit

final class ReservationFactory {
    static func createReservationController() -> ReservationController {
        let coordinator = ReservationCoordinator()
        let networkManager = NetworkManager()
        let viewModel = ReservationViewModel(coordinator: coordinator, networkManager: networkManager)
        let controller = ReservationController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
