//
//  RoomController.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 15.12.2023.
//

import SwiftUI

final class RoomController: UIHostingController<RoomView> {
    private let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.Medium.m18
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textColor = UIColor.black
        
        return label
    }()
    
    init(viewModel: RoomViewModel, with title: String) {
        super.init(rootView: RoomView(viewModel: viewModel))
        titleLabel.text = title
        navigationItem.titleView = titleLabel
        navigationItem.backButtonDisplayMode = .minimal
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        assertionFailure(Constants.roomControllerFailed)
    }
}
