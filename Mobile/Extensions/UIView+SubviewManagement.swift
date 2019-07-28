//
//  UIView+SubviewManagement.swift
//  Mobile
//
//  Created by Shady Mustafa on 17.07.19.
//  Copyright © 2019 Ebay. All rights reserved.
//

import UIKit

public extension UIView {
    
    /**
     Call this method if you want your view to have exact frame as its superview. Layout constraints will be added programmatically.
     */
    func bindInside(_ superView: UIView, inset: UIEdgeInsets = UIEdgeInsets.zero) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        superView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(\(inset.left))-[subview]-(\(inset.right))-|",
            options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["subview": self]))
        superView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(\(inset.top))-[subview]-(\(inset.bottom))-|",
            options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["subview": self]))
    }
    
    func insertOnBottomAndBoundInside(_ subview: UIView, inset: UIEdgeInsets = UIEdgeInsets.zero) {
        insertSubview(subview, at: 0)
        subview.bindInside(self, inset: inset)
    }
    
    func addOnTopAndBindInside(_ subview: UIView, insets: UIEdgeInsets = UIEdgeInsets.zero) {
        addSubview(subview)
        subview.bindInside(self, inset: insets)
    }
}
