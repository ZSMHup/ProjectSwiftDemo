//
//  HomeWebViewController.swift
//  ProjectSwiftDemo
//
//  Created by 张书孟 on 2018/9/7.
//  Copyright © 2018年 zsm. All rights reserved.
//

import UIKit
import WebKit

class HomeWebViewController: BaseViewController {

    private lazy var webContainer: WebViewContainer = {
        let webContainer = WebViewContainer()
        webContainer.load(url: URL(string: url))
        webContainer.delegate = self
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

extension HomeWebViewController: WebViewContainerDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if let url: URL = navigationAction.request.url, let scheme = url.scheme, scheme == "ellabook2" {
            customActionHandler(url: url)
            decisionHandler(.cancel)
            return
        }
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let str = "document.getElementsByClassName('btn_share_Wrap')[0].remove();"
        webView.evaluateJavaScript(str, completionHandler: nil)
    }
    
    private func customActionHandler(url: URL) {
        if let host = url.host, host == "detail.book" {
            if let tempArr1 = url.query?.components(separatedBy: "&"), let tempArr2 = tempArr1.first?.components(separatedBy: "="), let bookCode = tempArr2.last {
                navigationController?.pushViewController(BookDetailViewController(bookCode: bookCode), animated: true)
            }
        }
    }
}
