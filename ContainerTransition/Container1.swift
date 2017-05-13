//
//  Container1.swift
//  ContainerTransition
//
//  Created by Paweł Wojtkowiak on 13.05.2017.
//  Copyright © 2017 Paweł Wojtkowiak. All rights reserved.
//

import Foundation
import UIKit

class Container1: ContainerViewController {
    
    static let storyboardName = "Main"
    
    @IBOutlet weak var buttonDivider: UIView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    static func instantiate() -> Container1 {
        return UIStoryboard(name: Container1.storyboardName, bundle: nil).instantiateViewController(withIdentifier: "Container1") as! Container1
    }
    
    override func viewDidLoad() {
        leftButton.addTarget(self, action: #selector(tapAnimate), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(tapAnimate), for: .touchUpInside)
        
        leftButton.addTarget(self, action: #selector(touchDown), for: .touchDown)
        rightButton.addTarget(self, action: #selector(touchDown), for: .touchDown)
        
        leftButton.addTarget(self, action: #selector(touchCancel), for: .touchUpOutside)
        rightButton.addTarget(self, action: #selector(touchCancel), for: .touchUpOutside)
        
        leftButton.addTarget(self, action: #selector(touchCancel), for: .touchCancel)
        rightButton.addTarget(self, action: #selector(touchCancel), for: .touchCancel)
        
        leftButton.layer.borderWidth = 1.0
        rightButton.layer.borderWidth = 1.0
        
        leftButton.layer.borderColor = UIColor.lightGray.cgColor
        rightButton.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func tapAnimate(_ button: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {
            self.buttonDivider.alpha = 0.0
            button.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: { _ in
            UIView.animate(withDuration: 0.1) {
                self.buttonDivider.alpha = 1.0
                button.transform = CGAffineTransform.identity
            }
        })
    }
    
    func touchDown(_ button: UIButton) {
        UIView.animate(withDuration: 0.1) {
            self.buttonDivider.alpha = 0.0
            button.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
    }
    
    func touchCancel(_ button: UIButton) {
        UIView.animate(withDuration: 0.1) {
            self.buttonDivider.alpha = 1.0
            button.transform = CGAffineTransform.identity
        }
    }
    
}
