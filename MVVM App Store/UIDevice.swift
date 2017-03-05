//
//  UIDevice.swift
//  MVVM App Store
//
//  Created by Jake Young on 3/5/17.
//  Copyright © 2017 Jake Young. All rights reserved.
//

import UIKit

extension UIDevice {
    
    var is_iPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    var is_iPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
}
