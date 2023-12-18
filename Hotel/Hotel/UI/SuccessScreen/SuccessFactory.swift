//
//  SuccessFactory.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 16.12.2023.
//

import UIKit

final class SuccessFactory {
    static func createSuccessController() -> SuccessController {
        let coordinator = SuccessCoordinator()
        let viewModel = SuccessViewModel(coordinator: coordinator)
        let controller = SuccessController(viewModel: viewModel)
        coordinator.router = controller
        
        return controller
    }
}
