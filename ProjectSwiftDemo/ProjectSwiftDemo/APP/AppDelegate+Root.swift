//
//  AppDelegate+Root.swift
//  ProjectSwiftDemo
//
//  Created by 张书孟 on 2018/9/6.
//  Copyright © 2018年 zsm. All rights reserved.
//

import UIKit

extension AppDelegate {
    
    func setRootViewController() {
        UIViewController.setupNavigationBar
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        
        let main = MainTabBarController()
        window?.rootViewController = main
        window?.makeKeyAndVisible()
    }
}
