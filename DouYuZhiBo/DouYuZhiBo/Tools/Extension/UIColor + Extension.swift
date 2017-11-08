//
//  UIColor + Extension.swift
//  DouYuZhiBo
//
//  Created by MrChen on 2017/11/7.
//  Copyright © 2017年 MrChen. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        
        self.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
    }
}
