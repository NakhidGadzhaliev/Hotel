//
//  HotelController.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 14.12.2023.
//

import SwiftUI

final class HotelController: UIHostingController<HotelView> {
    private enum Constants {
        static let title = "Отель"
        static let failed = "Failed HotelController"
    }
    
    private let attributedString = NSAttributedString(
        string: Constants.title,
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
        assertionFailure(Constants.failed)
    }
}
