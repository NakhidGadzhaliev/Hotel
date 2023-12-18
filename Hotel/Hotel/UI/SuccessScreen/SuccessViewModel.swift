//
//  SuccessViewModel.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 16.12.2023.
//

import SwiftUI

final class SuccessViewModel: ObservableObject {
    private let coordinator: SuccessCoordinator
    
    init(coordinator: SuccessCoordinator) {
        self.coordinator = coordinator
    }
    
    func backToRootScreen() {
        coordinator.backToRootScreen()
    }
}
