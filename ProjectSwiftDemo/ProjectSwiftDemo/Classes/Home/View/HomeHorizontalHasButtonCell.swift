//
//  HomeHorizontalHasButtonCell.swift
//  ProjectSwiftDemo
//
//  Created by 张书孟 on 2018/9/7.
//  Copyright © 2018年 zsm. All rights reserved.
//

import UIKit

class HomeHorizontalHasButtonCell: UICollectionViewCell {
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout().chain
            .scrollDirection(.horizontal)
            .minimumLineSpacing(20.wpx)
            .itemSize(width: 317.wpx, height: 162.hpx)
            .build
        return UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout).chain
            .backgroundColor(UIColor.global)
            .delegate(self)
            .dataSource(self)
            .contentInset(top: 0, left: 36.wpx, bottom: 0, right: 36.wpx)
            .showsHorizontalScrollIndicator(false)
            .register(HomeHorizontalHasButtonCollectionCell.self, forCellWithReuseIdentifier: "HomeHorizontalHasButtonCollectionCell")
            .build
    }()
    
    var dataSource: [BookListModel] = [BookListModel]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var didSelectedItem: (Int) -> Void = { _ in }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HomeHorizontalHasButtonCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeHorizontalHasButtonCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeHorizontalHasButtonCollectionCell", for: indexPath) as! HomeHorizontalHasButtonCollectionCell
        cell.update(model: dataSource[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectedItem(indexPath.item)
    }
}
