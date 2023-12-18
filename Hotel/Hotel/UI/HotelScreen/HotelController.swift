//
//  HotelController.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 14.12.2023.
//

import SwiftUI

final class HotelController: UIHostingController<HotelView> {
    private enum Constants {
        static let hotel = "Отель"
        static let failed = "Failed HotelController"
    }
    
    init(viewModel: HotelViewModel) {
        super.init(rootView: HotelView(viewModel: viewModel))
        title = Constants.hotel
        navigationItem.backButtonDisplayMode = .minimal
        UINavigationBar.appearance().tintColor = .black
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        assertionFailure(Constants.failed)
    }
}
