//
//  SubjectAllViewController.swift
//  ProjectSwiftDemo
//
//  Created by 张书孟 on 2018/9/10.
//  Copyright © 2018年 zsm. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class SubjectAllViewController: ButtonBarPagerTabStripViewController {

    private lazy var categoryBtn: UIButton = {
        UIButton().chain
            .backgroundColor(UIColor.white)
            .image(#imageLiteral(resourceName: "arrows_btn_down"), for: .normal)
            .image(#imageLiteral(resourceName: "arrows_btn_up"), for: .selected)
            .build
    }()
    
    
    let categoryArray: [SubjectTitleListModel]
    init(categoryArray: [SubjectTitleListModel]) {
        self.categoryArray = categoryArray
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        config()
        super.viewDidLoad()
        
        settingButtonBarView()
        addSubViews()
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        var childViewControllers: [UIViewController] = [UIViewController]()
        for model in categoryArray {
            let child = SubjectAllChildViewController(categoryModel: model)
            childViewControllers.append(child)
        }
        return childViewControllers
    }

}

extension SubjectAllViewController {
    
    private func config() {
        settings.style.selectedBarVerticalAlignment = .bottom
        settings.style.buttonBarHeight = 47.hpx + UIApplication.shared.navigationBarHeight
        settings.style.buttonBarItemFont = UIFont.systemFont(ofSize: 16)
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.buttonBarLeftContentInset = 36.wpx
        settings.style.buttonBarRightContentInset = 86.wpx
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .light
            newCell?.label.textColor = .theme
        }
    }
    
    private func settingButtonBarView() {
        buttonBarView.selectedBar.backgroundColor = .theme
        buttonBarView.backgroundColor = .white
        buttonBarView.snp.makeConstraints { (make) in
            make.top.equalTo(topLayoutGuideBottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(47.hpx)
        }
        buttonBarView.layoutIfNeeded()
    }
    
    private func addSubViews() {
        view.addSubview(categoryBtn)
        categoryBtn.snp.makeConstraints { (make) in
            make.top.equalTo(topLayoutGuideBottom)
            make.right.equalToSuperview()
            make.size.equalTo(CGSize(width: 50.wpx, height: 47.hpx))
        }
    }
}
