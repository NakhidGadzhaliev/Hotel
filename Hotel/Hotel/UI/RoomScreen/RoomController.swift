//
//  RoomController.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 15.12.2023.
//

import SwiftUI

final class RoomController: UIHostingController<RoomView> {
    private enum Constants {
        static let failed = "Failed RoomController"
    }
    
    init(viewModel: RoomViewModel, with title: String) {
        super.init(rootView: RoomView(viewModel: viewModel))
        
        self.title = NSAttributedString(
            string: title,
            attributes: [
                .font: UIFont.Medium.m18,
                .foregroundColor: UIColor.black
            ]
        ).string
        navigationItem.backButtonDisplayMode = .minimal
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        assertionFailure(Constants.failed)
    }
}
