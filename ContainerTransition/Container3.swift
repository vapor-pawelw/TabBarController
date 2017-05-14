//
//  Container3.swift
//  ContainerTransition
//
//  Created by Paweł Wojtkowiak on 14.05.2017.
//  Copyright © 2017 Paweł Wojtkowiak. All rights reserved.
//

import Foundation
import UIKit

class Container3: ContainerViewController {
    
    static let storyboardName = "Main"
    
    static func instantiate() -> Container3 {
        return UIStoryboard(name: Container3.storyboardName, bundle: nil).instantiateViewController(withIdentifier: "Container3") as! Container3
    }
}
