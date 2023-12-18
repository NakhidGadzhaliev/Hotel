//
//  NavigationRouter.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 14.12.2023.
//

import UIKit

protocol NavigationRouter: AnyObject {
    func push(controller: UIViewController, isAnimated: Bool)
    func pop(isAnimated: Bool)
    func popToRootView(isAnimated: Bool)
}

extension UIViewController: NavigationRouter {
    func push(controller: UIViewController, isAnimated: Bool = true) {
        navigationController?.pushViewController(controller, animated: isAnimated)
    }
    
    func pop(isAnimated: Bool = true) {
        navigationController?.popViewController(animated: isAnimated)
    }
    
    func popToRootView(isAnimated: Bool) {
        navigationController?.popToRootViewController(animated: isAnimated)
    }
}
