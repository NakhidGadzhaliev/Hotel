//
//  HotelCoordinator.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 14.12.2023.
//

import UIKit

final class HotelCoordinator {
    weak var router: NavigationRouter?
    
    func openRoomScreen(with title: String) {
        let controller = RoomFactory.createRoomController(with: title)
        router?.push(controller: controller, isAnimated: true)
    }
}
