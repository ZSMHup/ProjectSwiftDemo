//
//  SubjectAllChildNoViewController.swift
//  ProjectSwiftDemo
//
//  Created by 张书孟 on 2018/9/12.
//  Copyright © 2018年 zsm. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class SubjectAllChildNoViewController: BaseViewController, IndicatorInfoProvider {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    // MARK: - IndicatorInfoProvider
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "")
    }
}
