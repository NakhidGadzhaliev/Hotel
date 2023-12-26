//
//  ReservationController.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 15.12.2023.
//

import SwiftUI

final class ReservationController: UIHostingController<ReservationView> {
    private let attributedString = NSAttributedString(
        string: Constants.reservationTitle,
        attributes: [
            .font: UIFont.Medium.m18,
            .foregroundColor: UIColor.black
        ]
    )
    
    init(viewModel: ReservationViewModel) {
        super.init(rootView: ReservationView(viewModel: viewModel))
        title = attributedString.string
        navigationItem.backButtonDisplayMode = .minimal
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        assertionFailure(Constants.reservationControllerFailed)
    }
}
