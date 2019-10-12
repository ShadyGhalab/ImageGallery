//
//  UIViewController.swift
//  Mobile
//
//  Created by Shady Mustafa on 17.07.19.
//  Copyright © 2019 Babylon Health. All rights reserved.
//

import UIKit

extension UIViewController {
    public func embed(_ viewController: UIViewController) {
        embed(viewController, in: view)
    }
    
    public func embed(_ viewController: UIViewController, in containerView: UIView) {
        addChild(viewController)
        viewController.view.frame = containerView.frame
        containerView.addSubview(viewController.view)
        viewController.view.bindInside(containerView)
        viewController.didMove(toParent: self)
    }
    
    public func removeEmbedded(_ viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
}
