//
//  SubjectAllChildViewController.swift
//  ProjectSwiftDemo
//
//  Created by 张书孟 on 2018/9/10.
//  Copyright © 2018年 zsm. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import MJRefresh

class SubjectAllChildViewController: BaseViewController {

    private lazy var collectionView: UICollectionView = {
        
        let itemWidth = (UIScreen.width - 144.wpx) / 4
        
        let flowLayout = UICollectionViewFlowLayout().chain
            .itemSize(width: itemWidth - 10, height: 259.hpx)
            .sectionInset(top: 20, left: 0, bottom: 20, right: 0)
            .build
        return UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout).chain
            .backgroundColor(UIColor.global)
            .contentInset(top: 0, left: 36.wpx, bottom: 0, right: 36.wpx)
            .delegate(self)
            .dataSource(self)
            .register(HomeHorizontalCollectionCell.self, forCellWithReuseIdentifier: "HomeHorizontalCollectionCell")
            .build
    }()
    
    private var dataSource: [BookListModel] = [BookListModel]()
    private var page: Int = 0
    
    let categoryModel: SubjectTitleListModel
    init(categoryModel: SubjectTitleListModel) {
        self.categoryModel = categoryModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .global
        
        setupUI()
    }
}

extension SubjectAllChildViewController {
    private func setupUI() {
        disablesAdjustScrollViewInsets(collectionView)
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.bottom.right.equalToSuperview()
        }
        
        collectionView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            self?.page = 0
            self?.requestData()
        })
        
        collectionView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: { [weak self] in
            self?.page += 1
            self?.requestData()
        })
        
        collectionView.mj_header.beginRefreshing()
    }
}

extension SubjectAllChildViewController {
    private func requestData() {
        requestSubjectAllList(page: page, wikiCode: categoryModel.wikiCode, cacheCompletion: { (cacheModel) in
            if self.collectionView.mj_header.isRefreshing {
                self.dataSource = cacheModel
                self.collectionView.reloadData()
            }
        }, successCompletion: { (models) in
            Toast.hide()
            if self.collectionView.mj_header.isRefreshing {
                self.collectionView.mj_header.endRefreshing()
                self.dataSource.removeAll()
            }
            if self.collectionView.mj_footer.isRefreshing {
                self.collectionView.mj_footer.endRefreshing()
            }
            self.dataSource += models
            self.collectionView.reloadData()
        }) { (error) in
            if self.collectionView.mj_header.isRefreshing {
                self.collectionView.mj_header.endRefreshing()
            }
            if self.collectionView.mj_footer.isRefreshing {
                self.collectionView.mj_footer.endRefreshing()
            }
            Toast.show(info: error)
        }
    }
}

extension SubjectAllChildViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeHorizontalCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeHorizontalCollectionCell", for: indexPath) as! HomeHorizontalCollectionCell
        cell.updateSlidePro(model: dataSource[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension SubjectAllChildViewController: IndicatorInfoProvider {
    // MARK: - IndicatorInfoProvider
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: categoryModel.wikiName)
    }
}
