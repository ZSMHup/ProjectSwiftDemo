//
//  HomeWebViewController.swift
//  ProjectSwiftDemo
//
//  Created by 张书孟 on 2018/9/7.
//  Copyright © 2018年 zsm. All rights reserved.
//

import UIKit

class HomeWebViewController: BaseViewController {

    private lazy var webContainer: WebViewContainer = {
        let webContainer = WebViewContainer()
        webContainer.load(url: URL(string: url))
        return webContainer
    }()
    
    private let url: String
    
    init(url: String = "") {
        self.url = url.urlEncoding()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        disablesAdjustScrollViewInsets(webContainer.webView.scrollView)
        
        view.addSubview(webContainer)
        webContainer.snp.makeConstraints { (make) in
            make.top.equalTo(topLayoutGuideBottom)
            make.left.bottom.right.equalToSuperview()
        }
    }
}

//extension HomeWebViewController: WKNavigationDelegate {
//    
//}
