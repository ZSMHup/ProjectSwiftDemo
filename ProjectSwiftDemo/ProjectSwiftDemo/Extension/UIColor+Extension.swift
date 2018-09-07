//
//  UIColor+Extension.swift
//
//  Created by zhangshumeng on 2018/8/25.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

public extension UIColor {
    
    /// #F6F6F6
    public static var global: UIColor {
        return UIColor(hex: "#F6F6F6")
    }
    
    /// #2196F3
    public static var theme: UIColor {
        return UIColor(hex: "#2196F3")
    }
    
    /// #1D1D1D
    public static var globalBackground: UIColor {
        return UIColor(hex: "#1D1D1D")
    }
    
    /// #000000
    public static var dark: UIColor {
        return UIColor(hex: "#000000")
    }
    
    /// #777777
    public static var light: UIColor {
        return UIColor(hex: "#777777")
    }
    
    /// #888888
    public static var placeholder: UIColor {
        return UIColor(hex: "#888888")
    }
    
    /// #EFEFEF alpha 0.2
    public static var separator: UIColor {
        return UIColor(hex: "#EFEFEF").alpha(0.2)
    }
    
    public static func whiteWithAlpha(_ alpha: CGFloat) -> UIColor {
        return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: alpha)
    }
    
    public static func darkWithAlpha(_ alpha: CGFloat) -> UIColor {
        return UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: alpha)
    }
}

public extension UIColor {
    
    convenience init(hex string: String) {
        var hex = string.hasPrefix("#") ? String(string.dropFirst()) : string
        guard hex.count == 3 || hex.count == 6 else {
            self.init(white: 1.0, alpha: 0.0)
            return
        }
        if hex.count == 3 {
            for (index, char) in hex.enumerated() {
                hex.insert(char, at: hex.index(hex.startIndex, offsetBy: index * 2))
            }
        }
        
        self.init(red: CGFloat((Int(hex, radix: 16)! >> 16) & 0xFF) / 255.0,
                  green: CGFloat((Int(hex, radix: 16)! >> 8) & 0xFF) / 255.0,
                  blue: CGFloat((Int(hex, radix: 16)!) & 0xFF) / 255.0, alpha: 1.0)
    }
    
    func alpha(_ value: CGFloat) -> UIColor {
        return withAlphaComponent(value)
    }
}
