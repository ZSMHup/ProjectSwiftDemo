//
//  HistoryRecViewController.swift
//  ProjectSwiftDemo
//
//  Created by 张书孟 on 2018/9/11.
//  Copyright © 2018年 zsm. All rights reserved.
//

import UIKit
import MJRefresh

class HistoryRecViewController: BaseViewController {

    private lazy var tableView: UITableView = {
        UITableView().chain
            .delegate(self)
            .dataSource(self)
            .rowHeight(UITableViewAutomaticDimension)
            .estimatedRowHeight(100)
            .separatorStyle(.none)
            .plainFooterView()
            .backgroundColor(UIColor.global)
            .register(HistoryRecCell.self, forCellReuseIdentifier: "HistoryRecCell")
            .build
    }()
    
    private var dataSource: [HistoryRecModel] = [HistoryRecModel]()
    
    private var page: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigation.item.title = "历史推荐"
        
        addSubviews()
    }
}

extension HistoryRecViewController {
    private func addSubviews() {
        disablesAdjustScrollViewInsets(tableView)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(topLayoutGuideBottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            self?.page = 0
            self?.requestData()
        })
        
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: { [weak self] in
            self?.page += 1
            self?.requestData()
        })
        
        tableView.mj_header.beginRefreshing()
    }
}

extension HistoryRecViewController {
    
    private func requestData() {
        Toast.loading()
        requestHistoryRecList(page: page, cacheCompletion: { (cacheModel) in
            if self.tableView.mj_header.isRefreshing {
                self.dataSource = cacheModel
            }
        }, successCompletion: { (models) in
            if self.tableView.mj_header.isRefreshing {
                self.tableView.mj_header.endRefreshing()
                self.dataSource.removeAll()
            }
            if self.tableView.mj_footer.isRefreshing {
                self.tableView.mj_footer.endRefreshing()
            }
            Toast.hide()
            self.dataSource += models
            self.tableView.reloadData()
        }) { (error) in
            if self.tableView.mj_header.isRefreshing {
                self.tableView.mj_header.endRefreshing()
            }
            if self.tableView.mj_footer.isRefreshing {
                self.tableView.mj_footer.endRefreshing()
            }
            Toast.show(info: error)
        }
    }
}

extension HistoryRecViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HistoryRecCell = tableView.dequeueReusableCell(withIdentifier: "HistoryRecCell") as! HistoryRecCell
        cell.update(model: dataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataSource[indexPath.row]
        let webViewVC = HomeWebViewController(url: model.targetPage)
        webViewVC.navigation.item.title = "每日读绘本"
        navigationController?.pushViewController(webViewVC, animated: true)
    }
}
