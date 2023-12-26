//
//  HotelController.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 14.12.2023.
//

import SwiftUI

final class HotelController: UIHostingController<HotelView> {
    private let attributedString = NSAttributedString(
        string: Constants.hotelTitle,
        attributes: [
            .font: UIFont.Medium.m18,
            .foregroundColor: UIColor.black
        ]
    )
    
    init(viewModel: HotelViewModel) {
        super.init(rootView: HotelView(viewModel: viewModel))
        title = attributedString.string
        navigationItem.backButtonDisplayMode = .minimal
        UINavigationBar.appearance().tintColor = .black
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        assertionFailure(Constants.hotelControllerFailed)
    }
}
