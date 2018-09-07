//
//  CommonTabmanViewController.swift
//  ProjectSwiftDemo
//
//  Created by 张书孟 on 2018/9/7.
//  Copyright © 2018年 zsm. All rights reserved.
//

import UIKit
import Tabman
import Pageboy

class CommonTabmanViewController: TabmanViewController {

    private let viewControllers: [UIViewController]
    private let defaultPage: Page
    
    init(children: [(title: String, viewController: UIViewController)], defaultPage: Page = .first) {
        self.viewControllers = children.map { $0.viewController }
        self.defaultPage = defaultPage
        super.init(nibName: nil, bundle: nil)
        bar.items = children.map { Item(title: $0.title) }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        
        bar.location = .preferred
        bar.appearance = TabmanBar.Appearance({ (appearance) in
            appearance.layout.edgeInset = 50
            appearance.layout.height = .explicit(value: 47)
            appearance.layout.itemDistribution = .leftAligned
            appearance.layout.interItemSpacing = 17
            appearance.state.color = UIColor.darkWithAlpha(0.54)
            appearance.state.selectedColor = UIColor.theme
            appearance.indicator.color = UIColor.theme
            appearance.style.background = .solid(color: UIColor.red)
            appearance.text.font = UIFont.systemFont(ofSize: 16)
            appearance.text.selectedFont = UIFont.systemFont(ofSize: 16)
        })
    }

    func add(to viewController: UIViewController) {
        viewController.addChildViewController(self)
        viewController.view.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.top.equalTo(viewController.topLayoutGuideBottom)
            make.left.bottom.right.equalToSuperview()
        }
    }
}

extension CommonTabmanViewController: PageboyViewControllerDataSource {
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return defaultPage
    }
}
