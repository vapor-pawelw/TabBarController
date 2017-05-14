//
//  Container2.swift
//  ContainerTransition
//
//  Created by Paweł Wojtkowiak on 13.05.2017.
//  Copyright © 2017 Paweł Wojtkowiak. All rights reserved.
//

import Foundation
import UIKit

class Container2: ContainerViewController {
    
    static let storyboardName = "Main"
    
    static func instantiate() -> Container2 {
        return UIStoryboard(name: Container2.storyboardName, bundle: nil).instantiateViewController(withIdentifier: "Container2") as! Container2
    }
}
