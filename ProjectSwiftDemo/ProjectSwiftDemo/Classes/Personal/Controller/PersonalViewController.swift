//
//  PersonalViewController.swift
//  ProjectSwiftDemo
//
//  Created by 张书孟 on 2018/9/6.
//  Copyright © 2018年 zsm. All rights reserved.
//

import UIKit

class PersonalViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        requestSubjectList(page: 1, sourceCode: "S201712135AQPKA", cacheCompletion: { (cacheModel) in
            
        }, successCompletion: { (models) in
            debugPrint(models)
        }) { (error) in
            
        }
    }

}
