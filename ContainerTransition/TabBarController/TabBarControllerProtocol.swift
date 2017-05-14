//
//  TabBarControllerProtocol.swift
//  ContainerTransition
//
//  Created by Paweł Wojtkowiak on 13.05.2017.
//  Copyright © 2017 Paweł Wojtkowiak. All rights reserved.
//

import Foundation
import UIKit

protocol TabBarControllerProtocol: class {
    associatedtype ContainerType: UIViewController
    
    var tabBarManager: TabBarManager<ContainerType>? { get set }
    
    func setActiveTab(_ item: UITabBarItem?)
    func setActiveTab(index: Int)
}

extension TabBarControllerProtocol where Self: UIViewController {
    func setActiveTab(index: Int) {
        guard let tabBarManager = tabBarManager else {
            print("\(#function) has failed - initialize tabBarManager first")
            return
        }
        guard let items = tabBarManager.tabBar.items, items.count > index else {
            fatalError("Index for given item does not exist.")
        }
        
        setActiveTab(items[index])
        if tabBarManager.tabBar.selectedItem !== items[index] {
            tabBarManager.tabBar.selectedItem = items[index]
        }
    }
    
    func setActiveTab(_ item: UITabBarItem? = nil) {
        
        guard let tabBarManager = tabBarManager else {
            print("\(#function) has failed - initialize tabBarManager first")
            return
        }
        
        let activeItem: UITabBarItem
        if let item = item {
            activeItem = item
        } else {
            guard let selectedItem = tabBarManager.tabBar.selectedItem else {
                return
            }
            activeItem = selectedItem
        }
        
        guard let items = tabBarManager.tabBar.items else {
            fatalError("Tab bar items property is nil.")
        }
        
        guard let index = items.index(of: activeItem) else {
            fatalError("Index for given item does not exist.")
        }
        
        guard tabBarManager.previousTabIndex != index else {
            // already selected
            return
        }
        
        let viewController = tabBarManager.viewControllers[index]
        
        let transition: TabBarTransition
        if let previousTabIndex = tabBarManager.previousTabIndex {
            let direction: TabBarSlideTransition.Direction
            direction = (previousTabIndex < index) ? .right : .left
            transition = TabBarSlideTransition(direction: direction)
        } else {
            transition = TabBarInstantTransition()
        }
        
        transition.run(from: tabBarManager.currentViewController,
                       to: viewController,
                       containerView: tabBarManager.containerView,
                       parentViewController: self)
        
        tabBarManager.currentViewController = viewController
        tabBarManager.previousTabIndex = index
    }
}

// MARK: Transitions

protocol TabBarTransition {
    func run(from srcViewController: UIViewController?,
             to dstViewController: UIViewController,
             containerView: UIView,
             parentViewController: UIViewController)
}
