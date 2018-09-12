//
//  BookDetailViewController.swift
//  ProjectSwiftDemo
//
//  Created by 张书孟 on 2018/9/7.
//  Copyright © 2018年 zsm. All rights reserved.
//

import UIKit

class BookDetailViewController: BaseViewController {

    
    private let bookCode: String
    
    init(bookCode: String) {
        self.bookCode = bookCode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        debugPrint(bookCode)
    }

    

}
