//
//  AppDelegate+Services.swift
//  ProjectSwiftDemo
//
//  Created by 张书孟 on 2018/9/6.
//  Copyright © 2018年 zsm. All rights reserved.
//

import Toast_Swift

#if DEBUG
import CocoaDebug
#endif
import Bugly

let BuglyAppId = "ebbba0da9c"

extension AppDelegate {
    
    func registerServices() {
        
        configureCocoaDebug()
        configureBugly()
    }
    
    private func configureCocoaDebug() {
        #if DEBUG
        CocoaDebug.enable()
        CocoaDebug.recordCrash = true
        #endif
    }
    
    private func configureBugly() {
        Bugly.start(withAppId: BuglyAppId)
    }
}
