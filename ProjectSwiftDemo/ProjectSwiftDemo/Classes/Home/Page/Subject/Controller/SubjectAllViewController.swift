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
            .addTarget(self, action: #selector(categoryBtnClick(sender:)), for: .touchUpInside)
            .build
    }()
    
    private lazy var shadeView: UIView = {
        let shadeView = UIView(frame: UIScreen.main.bounds)
        shadeView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(shadeViewTap))
        shadeView.addGestureRecognizer(tap)
        return shadeView
    }()
    
    private lazy var categoryView: SubjectCategoryView = {
        SubjectCategoryView(categoryArray: categoryArray)
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
        navigation.item.title = "图书分类"
        settingButtonBarView()
        addSubViews()
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        var childViewControllers: [UIViewController] = [UIViewController]()
        for model in categoryArray {
            let child = SubjectAllChildViewController(categoryModel: model)
            childViewControllers.append(child)
        }
        
        guard !childViewControllers.isEmpty else {
            return [SubjectAllChildNoViewController()]
        }
        
        return childViewControllers
    }
    
    
}

extension SubjectAllViewController {
    
    private func config() {
        settings.style.selectedBarVerticalAlignment = .bottom
        settings.style.buttonBarHeight = 47.hpx + UIApplication.shared.navigationBarHeight
        settings.style.buttonBarItemFont = UIFont.systemFont(ofSize: 16.fontpx)
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
    
    private func addCategoryView() {
        shadeView.alpha = 1.0
        view.insertSubview(shadeView, belowSubview: categoryBtn)
        view.insertSubview(categoryView, belowSubview: categoryBtn)
        
        shadeView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        categoryView.snp.makeConstraints { (make) in
            make.top.equalTo(topLayoutGuideBottom)
            make.left.right.equalToSuperview()
        }
        
        UIView.animate(withDuration: 0.25) {
            self.categoryView.transform = .identity
        }
        
        categoryView.didSelected = { [weak self] in
            guard let `self` = self else { return }
            self.categoryBtn.isSelected = false
            self.hidden()
            if var index: Int = Int($0.idx) {
                index = index - 1
                if index <= 0 {
                    index = 0
                }
                if self.canMoveTo(index: index) {
                    self.moveToViewController(at: index, animated: true)
                }
            }
        }
    }
    
    @objc private func categoryBtnClick(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            addCategoryView()
        } else {
           hidden()
        }
    }
    
    @objc private func shadeViewTap() {
        hidden()
        categoryBtn.isSelected = false
    }
    
    private func hidden() {
        UIView.animate(withDuration: 0.25, animations: {
            self.categoryView.transform = CGAffineTransform(translationX: 0, y: -self.categoryView.frame.size.height)
            self.shadeView.alpha = 0
        }) { (finished) in
            self.categoryView.removeFromSuperview()
        }
    }
}

extension SubjectAllViewController {
    
}
