//
//  ViewController.swift
//  ContainerTransition
//
//  Created by Paweł Wojtkowiak on 13.05.2017.
//  Copyright © 2017 Paweł Wojtkowiak. All rights reserved.
//

import UIKit

enum Tab: Int {
    case first
    case second
    
    static let all: [Tab] = [.first, .second]
    func instantiate() -> ContainerViewController {
        switch self {
        case .first:
            return Container1.instantiate()
        case .second:
            return Container2.instantiate()
        }
    }
}

class ViewController: UIViewController, TabBarControllerProtocol {
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var containerView: UIView!
    var tabBarManager: TabBarManager<ContainerViewController>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarManager = TabBarManager(tabBar: tabBar,
                                      viewControllers: Tab.all.map { $0.instantiate() },
                                      containerView: containerView)
        setActiveTab(index: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        setActiveTab(item)
    }
}
