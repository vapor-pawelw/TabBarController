//
//  TabBarInstantTransition.swift
//  ContainerTransition
//
//  Created by Paweł Wojtkowiak on 14.05.2017.
//  Copyright © 2017 Paweł Wojtkowiak. All rights reserved.
//

import Foundation
import UIKit

class TabBarInstantTransition: TabBarTransition {
    func run(from srcViewController: UIViewController?,
             to dstViewController: UIViewController,
             containerView: UIView,
             parentViewController: UIViewController) {
        if let currentContainer = srcViewController {
            currentContainer.view.removeFromSuperview()
            currentContainer.removeFromParentViewController()
        }
        
        parentViewController.addChildViewController(dstViewController)
        
        containerView.addSubview(dstViewController.view)
        dstViewController.view.translatesAutoresizingMaskIntoConstraints = false
        dstViewController.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        dstViewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        dstViewController.view.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        dstViewController.view.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        
        dstViewController.didMove(toParentViewController: parentViewController)
    }
}
