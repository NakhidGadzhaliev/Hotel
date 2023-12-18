//
//  ReservationCoordinator.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 15.12.2023.
//

import UIKit

final class ReservationCoordinator {
    weak var router: NavigationRouter?
    
    func openSuccessScreen() {
        let controller = SuccessFactory.createSuccessController()
        router?.push(controller: controller, isAnimated: true)
    }
}
