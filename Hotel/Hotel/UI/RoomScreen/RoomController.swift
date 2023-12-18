//
//  RoomController.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 15.12.2023.
//

import SwiftUI

final class RoomController: UIHostingController<RoomView> {
    init(viewModel: RoomViewModel, with title: String) {
        super.init(rootView: RoomView(viewModel: viewModel))
        self.title = title
        navigationItem.backButtonDisplayMode = .minimal
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        assertionFailure("Failed RoomController")
    }
}
