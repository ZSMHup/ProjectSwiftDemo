//
//  HomeWebCell.swift
//  ProjectSwiftDemo
//
//  Created by 张书孟 on 2018/9/6.
//  Copyright © 2018年 zsm. All rights reserved.
//

import UIKit

class HomeWebCell: UICollectionViewCell {
    
    lazy var subjectLabel: UILabel = {
        UILabel().chain
            .textColor(UIColor.dark)
            .systemFont(ofSize: 14.fontpx)
            .numberOfLines(2)
            .build
    }()
    
    lazy var imgView: UIImageView = {
        UIImageView()
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(subjectLabel)
        contentView.addSubview(imgView)
        
        subjectLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(36.wpx)
            make.right.equalTo(contentView.snp.right).offset(-36.wpx)
            make.top.equalToSuperview()
        }
        
        imgView.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(36.wpx)
            make.right.equalTo(contentView.snp.right).offset(-36.wpx)
            make.top.equalTo(subjectLabel.snp.bottom).offset(12.hpx)
            make.bottom.equalTo(contentView.snp.bottom).offset(-20.5.hpx)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
