//
//  HomeSubjectCollectionCell.swift
//  ProjectSwiftDemo
//
//  Created by 张书孟 on 2018/9/6.
//  Copyright © 2018年 zsm. All rights reserved.
//

import UIKit

class HomeSubjectCollectionCell: UICollectionViewCell {
    
    lazy var imgView: UIImageView = {
        UIImageView()
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeSubjectCollectionCell {
    private func addSubViews() {
        contentView.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
