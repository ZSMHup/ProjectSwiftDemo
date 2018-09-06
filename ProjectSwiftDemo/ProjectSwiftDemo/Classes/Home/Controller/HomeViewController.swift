//
//  HomeViewController.swift
//  ProjectSwiftDemo
//
//  Created by 张书孟 on 2018/9/6.
//  Copyright © 2018年 zsm. All rights reserved.
//

import UIKit
import CocoaChainKit
import MJRefresh
import Kingfisher

class HomeViewController: BaseViewController {

    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout().chain.build
        return UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout).chain
            .backgroundColor(UIColor.white)
            .delegate(self)
            .dataSource(self)
            .register(HomeSubjectCell.self, forCellWithReuseIdentifier: "HomeSubjectCell")
            .register(HomeWebCell.self, forCellWithReuseIdentifier: "HomeWebCell")
            .build
    }()
    
    private var subjectArray: [HomeSubjectListModel] = [HomeSubjectListModel]()
    private var homeListArray: [HomeListModel] = [HomeListModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

// MARK: 数据请求
extension HomeViewController {
    private func requestHomeData() {
        Toast.loading()
        let group = DispatchGroup()
        
        group.enter()
        requestHomeSubjectList(cacheCompletion: { cacheModels in
            if self.collectionView.mj_header.isRefreshing {
                self.subjectArray = cacheModels
            }
        }, successCompletion: { (models) in
            group.leave()
            self.subjectArray = models
        }) { (error) in
            group.leave()
            Toast.show(info: error)
        }
        
        group.enter()
        requestHomeAllList(cacheCompletion: { (cacheModels) in
            if self.collectionView.mj_header.isRefreshing {
                self.homeListArray = cacheModels
            }
        }, successCompletion: { (models) in
            group.leave()
            self.homeListArray = models
        }) { (error) in
            group.leave()
            Toast.show(info: error)
        }
        
        group.notify(queue: .main) { [weak self] in
            Toast.hide()
            guard let `self` = self else { return }
            if self.collectionView.mj_header.isRefreshing {
                self.collectionView.mj_header.endRefreshing()
            }
            debugPrint(self.subjectArray.count, self.homeListArray.count)
            self.collectionView.reloadData()
        }
    }
}

extension HomeViewController {
    private func setupUI() {
        disablesAdjustScrollViewInsets(collectionView)
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(topLayoutGuideBottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuideBottom)
        }
        
        collectionView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            self?.requestHomeData()
        })
        
        collectionView.mj_header.beginRefreshing()
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return homeListArray.count + (subjectArray.isEmpty ? 0 : 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if !subjectArray.isEmpty, section == 0 {
            return 1
        }
        
        let model: HomeListModel = homeListArray[section - (subjectArray.isEmpty ? 0 : 1)]
        
        if model.partStyle == "SLIDE_PORTRAIT" {
            return model.bookList.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if !subjectArray.isEmpty, indexPath.section == 0 {
            let cell: HomeSubjectCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeSubjectCell", for: indexPath) as! HomeSubjectCell
            cell.didSelectedItem = { index in
                debugPrint(index)
            }
            return cell
        }
        
        let model: HomeListModel = homeListArray[indexPath.section - (subjectArray.isEmpty ? 0 : 1)]
        
        switch model.partStyle {
        case "SLIDE_PORTRAIT": /// 竖向
            
            break
        case "DAILY_BOOK": /// 单个或者横向
            let cell: HomeWebCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeWebCell", for: indexPath) as! HomeWebCell
            if let dailyListModel = model.dailyList.first {
                cell.subjectLabel.text = dailyListModel.dailyTitle
                cell.imgView.kf.setImage(with: URL(string: dailyListModel.dailyImg))
            }
            return cell
        case "IMAGE_TEXT": /// 单个或者横向
            
            break
        default: /// 单个或者横向
            
            break
        }
        
        let cell: HomeSubjectCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeSubjectCell", for: indexPath) as! HomeSubjectCell
        cell.didSelectedItem = { index in
            debugPrint(index)
        }
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if !subjectArray.isEmpty, indexPath.section == 0 {
            return CGSize(width: UIScreen.width, height: 143.hpx)
        }
        
        let model: HomeListModel = homeListArray[indexPath.section - (subjectArray.isEmpty ? 0 : 1)]
        switch model.partStyle {
        case "SLIDE_PORTRAIT": /// 竖向
            return CGSize(width: 156.wpx, height: 258.5.hpx)
        case "DAILY_BOOK": /// 单个或者横向
            return CGSize(width: UIScreen.width, height: 397.5.hpx)
        case "IMAGE_TEXT": /// 单个或者横向
            return CGSize(width: UIScreen.width, height: 175.hpx)
        default: /// 单个或者横向
            return CGSize(width: UIScreen.width, height: 165.hpx)
        }
    }
}
