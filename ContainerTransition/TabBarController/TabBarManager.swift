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
    
    fileprivate var previousTabIndex: Int?
    
    init(tabBar: UITabBar,
         viewControllers: [ContainerType],
         containerView: UIView) {
        self.viewControllers = viewControllers
        self.containerView = containerView
        self.tabBar = tabBar
    }
}
