//
//  MockNavigationController.swift
//  ToDoApp
//
//  Created by Никита Новицкий on 30.07.2025.
//

import UIKit

class MockNavigationController: UINavigationController {
    var vcIsPushed: Bool = false
    var vcIsPopped: Bool = false

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        vcIsPushed = true
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        vcIsPopped = true
        return viewControllers.first
    }
}
