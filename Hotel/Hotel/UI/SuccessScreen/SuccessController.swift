//
//  SuccessController.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 16.12.2023.
//

import SwiftUI

final class SuccessController: UIHostingController<SuccessView> {
    private enum Constants {
        static let title = "Заказ оплачен"
        static let failed = "Failed SuccessController"
    }
    
    private let attributedString = NSAttributedString(
        string: Constants.title,
        attributes: [
            .font: UIFont.Medium.m18,
            .foregroundColor: UIColor.black
        ]
    )
    
    init(viewModel: SuccessViewModel) {
        super.init(rootView: SuccessView(viewModel: viewModel))
        title = attributedString.string
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        assertionFailure(Constants.failed)
    }
}
