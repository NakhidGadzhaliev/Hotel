//
//  ReservationController.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 15.12.2023.
//

import SwiftUI

final class ReservationController: UIHostingController<ReservationView> {
    init(viewModel: ReservationViewModel) {
        super.init(rootView: ReservationView(viewModel: viewModel))
        title = "Бронирование"
        navigationItem.backButtonDisplayMode = .minimal
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        assertionFailure("Failed ReservationController")
    }
}
