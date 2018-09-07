//
//  BaseNavigationController.swift
//  ProjectSwiftDemo
//
//  Created by 张书孟 on 2018/9/6.
//  Copyright © 2018年 zsm. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigation.item.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "white_back"), style: .plain, target: self, action: #selector(backBtnClick))
        }
        super.pushViewController(viewController, animated: true)
    }
    
    @objc private func backBtnClick() {
        self.popViewController(animated: true)
    }
}
