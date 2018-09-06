//
//  MainTabBarController.swift
//  ProjectSwiftDemo
//
//  Created by 张书孟 on 2018/9/6.
//  Copyright © 2018年 zsm. All rights reserved.
//

import UIKit
import EachNavigationBar

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let homeVC = HomeViewController()
        let homeNav = configureNavigationController(homeVC)
        homeNav.tabBarItem.image = #imageLiteral(resourceName: "tab_community_nor")
        homeNav.tabBarItem.selectedImage = #imageLiteral(resourceName: "tab_community_press")
        
        let personalVC = PersonalViewController()
        let personalNav = configureNavigationController(personalVC)
        personalNav.tabBarItem.image = #imageLiteral(resourceName: "tab_me_nor")
        personalNav.tabBarItem.selectedImage = #imageLiteral(resourceName: "tab_me_press")
        
        viewControllers = [homeNav, personalNav]
    }

    private func configureNavigationController(_ viewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: viewController)
        nav.navigationBar.barStyle = .default
        nav.navigation.configuration.isEnabled = true
        nav.navigation.configuration.isTranslucent = false
        nav.navigation.configuration.barTintColor = UIColor.theme
        nav.navigation.configuration.titleTextAttributes = [.foregroundColor: UIColor.white,
                                                            .font: UIFont.boldSystemFont(ofSize: 16)]
        nav.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 10)], for: .normal)
        nav.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.global, .font: UIFont.systemFont(ofSize: 10)], for: .selected)
        return nav
    }

}
