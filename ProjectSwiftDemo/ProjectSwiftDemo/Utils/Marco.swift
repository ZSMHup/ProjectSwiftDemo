//
//  Marco.swift
//  ProjectSwiftDemo
//
//  Created by 张书孟 on 2018/9/12.
//  Copyright © 2018年 zsm. All rights reserved.
//

import UIKit

func isPad() -> Bool {
    if UIDevice.current.userInterfaceIdiom == .pad {
        return true
    }
    return false
}
