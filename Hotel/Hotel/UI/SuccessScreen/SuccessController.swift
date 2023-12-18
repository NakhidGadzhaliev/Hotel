//
//  SuccessController.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 16.12.2023.
//

import SwiftUI

final class SuccessController: UIHostingController<SuccessView> {
    init(viewModel: SuccessViewModel) {
        super.init(rootView: SuccessView(viewModel: viewModel))
        title = "Заказ оплачен"
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        assertionFailure("Failed SuccessController")
    }
}
