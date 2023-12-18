//
//  SuccessController.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 16.12.2023.
//

import SwiftUI

final class SuccessController: UIHostingController<SuccessView> {
    private enum Constants {
        static let orderPaid = "Заказ оплачен"
        static let failed = "Failed SuccessController"
    }
    
    init(viewModel: SuccessViewModel) {
        super.init(rootView: SuccessView(viewModel: viewModel))
        title = Constants.orderPaid
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        assertionFailure(Constants.failed)
    }
}
