//
//  TabBarSlideTransition.swift
//  ContainerTransition
//
//  Created by Paweł Wojtkowiak on 14.05.2017.
//  Copyright © 2017 Paweł Wojtkowiak. All rights reserved.
//

import Foundation
import UIKit

class TabBarSlideTransition: TabBarTransition {
    enum Direction: Int {
        case left
        case right
        
        fileprivate var value: CGFloat {
            return self == .left ? -1.0 : 1.0
        }
    }
    
    let direction: Direction
    
    init(direction: Direction) {
        self.direction = direction
    }
    
    func run(from srcViewController: UIViewController?,
             to dstViewController: UIViewController,
             containerView: UIView,
             parentViewController: UIViewController) {
        
        guard let currentContainer = srcViewController else {
            fatalError("Source view controller must be specified for this transition")
        }
        
        func snapshot(of view: UIView) -> UIView {
            UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0)
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: false)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            let imageView = UIImageView(image: image)
            imageView.frame = view.bounds
            return imageView
        }
        
        let snapshotView = snapshot(of: currentContainer.view)
        
        // x
        
        currentContainer.view.removeFromSuperview()
        containerView.addSubview(dstViewController.view)
        dstViewController.view.translatesAutoresizingMaskIntoConstraints = false
        dstViewController.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        dstViewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        dstViewController.view.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        dstViewController.view.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        currentContainer.removeFromParentViewController()
        parentViewController.addChildViewController(dstViewController)
        dstViewController.didMove(toParentViewController: parentViewController)
        
        // --x
        
        parentViewController.view.insertSubview(snapshotView, aboveSubview: containerView)
        snapshotView.frame = containerView.frame
        containerView.transform = CGAffineTransform(translationX: direction.value * containerView.frame.size.width, y: 0)
        
        // do whatever updates to the views you want here
        // -
        
        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       options: .curveEaseOut,
                       animations: {
                        snapshotView.transform = CGAffineTransform(translationX: -self.direction.value * containerView.bounds.size.width, y: 0)
                        containerView.transform = .identity
        }, completion: { success in
            snapshotView.removeFromSuperview()
        })
    }
}
