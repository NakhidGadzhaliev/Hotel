//
//  RoomFactory.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 15.12.2023.
//

import UIKit

final class RoomFactory {
    static func createRoomController(with title: String) -> RoomController {
        let coordinator = RoomCoordinator()
        let networkManager = NetworkManager()
        let viewModel = RoomViewModel(coordinator: coordinator, networkManager: networkManager)
        let controller = RoomController(viewModel: viewModel, with: title)
        coordinator.router = controller
        
        return controller
    }
}
