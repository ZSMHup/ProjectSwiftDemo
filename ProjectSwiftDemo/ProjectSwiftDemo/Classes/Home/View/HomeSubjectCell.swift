//
//  HomeSubjectCell.swift
//  ProjectSwiftDemo
//
//  Created by 张书孟 on 2018/9/6.
//  Copyright © 2018年 zsm. All rights reserved.
//

import UIKit

class HomeSubjectCell: UICollectionViewCell {
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout().chain
            .scrollDirection(.horizontal)
            .sectionInset(top: 12.hpx, left: 0, bottom: 10.hpx, right: 0)
            .minimumLineSpacing(4.wpx)
            .itemSize(width: 176.wpx, height: 121.hpx)
            .build
        return UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout).chain
            .backgroundColor(UIColor.white)
            .delegate(self)
            .dataSource(self)
            .contentInset(top: 0, left: 26.wpx, bottom: 0, right: 26.wpx)
            .showsHorizontalScrollIndicator(false)
            .register(HomeSubjectCollectionCell.self, forCellWithReuseIdentifier: "HomeSubjectCollectionCell")
            .build
    }()
    
    private lazy var dataSource: [UIImage] = {
        return [#imageLiteral(resourceName: "all_category"), #imageLiteral(resourceName: "free_ prefecture"), #imageLiteral(resourceName: "hot_book"), #imageLiteral(resourceName: "new_ putaway")]
    }()
    
    var didSelectedItem: (Int) -> Void = { _ in }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeSubjectCell {
    private func addSubViews() {
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension HomeSubjectCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeSubjectCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeSubjectCollectionCell", for: indexPath) as! HomeSubjectCollectionCell
        cell.imgView.image = dataSource[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectedItem(indexPath.item)
    }
}
