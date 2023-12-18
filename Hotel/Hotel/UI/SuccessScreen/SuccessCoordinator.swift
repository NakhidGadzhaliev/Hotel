//
//  SuccessCoordinator.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 16.12.2023.
//

import UIKit

final class SuccessCoordinator {
    weak var router: NavigationRouter?
    
    func backToRootScreen() {
        router?.popToRootView(isAnimated: true)
    }
}
