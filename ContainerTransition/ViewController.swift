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
    case third
    
    static let all: [Tab] = [.first, .second, .third]
    func instantiate() -> ContainerViewController {
        switch self {
        case .first:
            return Container1.instantiate()
        case .second:
            return Container2.instantiate()
        case .third:
            return Container3.instantiate()
        }
    }
}

class ViewController: UIViewController, TabBarControllerProtocol {
    
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var containerView: UIView!
    var tabBarManager: TabBarManager<ContainerViewController>?
    var animator: UIViewPropertyAnimator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarManager = TabBarManager(tabBar: tabBar,
                                      viewControllers: Tab.all.map { $0.instantiate() },
                                      containerView: containerView)
        searchBar.backgroundImage = UIImage()
        
        setActiveTab(index: 0)
        
        animator = UIViewPropertyAnimator(duration: 0.1,
                                          curve: .linear) {
                                            self.visualEffectView.effect = nil
        }
        
        animator?.startAnimation()
        animator?.pauseAnimation()
        animator?.fractionComplete = 0.7
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
