//
//  Pixel+Extension.swift
//
//  Created by zhangshumeng on 2018/8/25.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

var baseWidth: CGFloat = 375.0
var baseheight: CGFloat = 812.0

public extension CGFloat {
    
    var wpx: CGFloat {
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            baseWidth = 768.0
        }
        
        return UIScreen.width / baseWidth * self
    }
    
    var hpx: CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            baseheight = 1024.0
        }
        return UIScreen.height / baseheight * self
    }
}

public extension Double {
    
    var wpx: CGFloat {
        return CGFloat(self).wpx
    }
    
    var hpx: CGFloat {
        return CGFloat(self).hpx
    }
}

public extension Int {
    
    var wpx: CGFloat {
        return CGFloat(self).wpx
    }
    
    var hpx: CGFloat {
        return CGFloat(self).hpx
    }
}

public extension UIScreen {
    
    static var width: CGFloat {
        return main.bounds.width
    }
    
    static var height: CGFloat {
        return main.bounds.height
    }
}

public extension CGFloat {
    
    static var min: CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    static var max: CGFloat {
        return CGFloat.greatestFiniteMagnitude
    }
}
