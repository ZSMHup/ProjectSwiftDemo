//
//  HomeSubjectViewController.swift
//  ProjectSwiftDemo
//
//  Created by 张书孟 on 2018/9/7.
//  Copyright © 2018年 zsm. All rights reserved.
//

import UIKit
import Pageboy

class HomeSubjectViewController: BaseViewController {

    private let defaultPage: PageboyViewController.Page
    
    init(defaultPage: PageboyViewController.Page) {
        self.defaultPage = defaultPage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buildSubviews()
    }

    private func buildSubviews() {
        let tabmanVC = CommonTabmanViewController(
            children: [(title: "全部", viewController: HomeSubjectChildViewController()),
                       (title: "待支付", viewController: HomeSubjectChildViewController()),
                       (title: "服务中", viewController: HomeSubjectChildViewController()),
                       (title: "待评价", viewController: HomeSubjectChildViewController()),
                       (title: "退款/售后", viewController: HomeSubjectChildViewController()),
                       (title: "退款/售后", viewController: HomeSubjectChildViewController()),
                       (title: "退款/售后", viewController: HomeSubjectChildViewController()),
                       (title: "退款/售后", viewController: HomeSubjectChildViewController()),
                       (title: "退款/售后", viewController: HomeSubjectChildViewController()),
                       (title: "退款/售后", viewController: HomeSubjectChildViewController()),
                       (title: "退款/售后", viewController: HomeSubjectChildViewController()),
                       (title: "退款/售后", viewController: HomeSubjectChildViewController()),
                       (title: "退款/售后", viewController: HomeSubjectChildViewController()),
                       (title: "退款/售后", viewController: HomeSubjectChildViewController()),
                       (title: "退款/售后", viewController: HomeSubjectChildViewController()),
                       (title: "退款/售后", viewController: HomeSubjectChildViewController()),
                       (title: "退款/售后", viewController: HomeSubjectChildViewController()),
                       (title: "退款/售后", viewController: HomeSubjectChildViewController()),
                       (title: "退款/售后", viewController: HomeSubjectChildViewController()),
                       (title: "退款/售后", viewController: HomeSubjectChildViewController()),
                       (title: "退款/售后", viewController: HomeSubjectChildViewController()),
                       (title: "退款/售后", viewController: HomeSubjectChildViewController()),
                       (title: "退款/售后", viewController: HomeSubjectChildViewController()),
                       (title: "退款/售后", viewController: HomeSubjectChildViewController())],
            defaultPage: defaultPage)
        tabmanVC.add(to: self)
    }
}
