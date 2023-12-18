//
//  HotelController.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 14.12.2023.
//

import SwiftUI

final class HotelController: UIHostingController<HotelView> {
    init(viewModel: HotelViewModel) {
        super.init(rootView: HotelView(viewModel: viewModel))
        title = "Отель"
        navigationItem.backButtonDisplayMode = .minimal
        UINavigationBar.appearance().tintColor = .black
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        assertionFailure("Failed HotelController")
    }
}
