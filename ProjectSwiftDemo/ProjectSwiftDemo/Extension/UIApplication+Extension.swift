//
//  UIApplication+Extension.swift
//  SwiftTool
//
//  Created by 张书孟 on 2018/8/31.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

internal extension UIApplication {
    var preferredApplicationWindow: UIWindow? {
        
        if let appWindow = UIApplication.shared.delegate?.window, let window = appWindow {
            return window
        } else if let window = UIApplication.shared.keyWindow {
            return window
        }
        return nil
    }
    
    var navigationBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height + 44.0
    }
}
