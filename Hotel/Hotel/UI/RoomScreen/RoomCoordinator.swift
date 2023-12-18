//
//  RoomCoordinator.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 15.12.2023.
//

import UIKit

final class RoomCoordinator {
    weak var router: NavigationRouter?
    
    func openReservationScreen() {
        let controller = ReservationFactory.createReservationController()
        router?.push(controller: controller, isAnimated: true)
    }
}
