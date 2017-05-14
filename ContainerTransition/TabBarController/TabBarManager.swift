//
//  TabBarManager.swift
//  ContainerTransition
//
//  Created by Paweł Wojtkowiak on 14.05.2017.
//  Copyright © 2017 Paweł Wojtkowiak. All rights reserved.
//

import Foundation
import UIKit

class TabBarManager<ContainerType: UIViewController> {
    var viewControllers: [ContainerType]
    var currentViewController: ContainerType?
    var containerView: UIView!
    var tabBar: UITabBar
    
    internal var previousTabIndex: Int?
    
    init(tabBar: UITabBar,
         viewControllers: [ContainerType],
         containerView: UIView) {
        self.viewControllers = viewControllers
        self.containerView = containerView
        self.tabBar = tabBar
        
        guard let items = tabBar.items else {
            fatalError("Tab bar items property is nil.")
        }
        guard viewControllers.count == tabBar.items?.count else {
            fatalError("Tab bar items count (\(items.count)) is different from tab bar view controllers count (\(viewControllers.count)).")
        }
    }
}
