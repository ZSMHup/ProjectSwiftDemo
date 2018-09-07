//
//  HomeHorizontalHasButtonCollectionCell.swift
//  ProjectSwiftDemo
//
//  Created by 张书孟 on 2018/9/7.
//  Copyright © 2018年 zsm. All rights reserved.
//

import UIKit

class HomeHorizontalHasButtonCollectionCell: UICollectionViewCell {
    
    private lazy var bgView: UIView = {
        UIView().chain
            .cornerRadius(10)
            .masksToBounds(true)
            .backgroundColor(UIColor.white)
            .build
    }()
    
    private lazy var imgView: UIImageView = { UIImageView() }()
    
    private lazy var titleLabel: UILabel = {
        UILabel().chain
            .textColor(UIColor.dark)
            .systemFont(ofSize: 16)
            .numberOfLines(2)
            .build
    }()
    
    private lazy var subjectLabel: UILabel = {
        UILabel().chain
            .textColor(UIColor.dark)
            .systemFont(ofSize: 12)
            .numberOfLines(0)
            .build
    }()
    
    private lazy var readLabel: UILabel = {
        UILabel().chain
            .text("立即阅读")
            .textColor(UIColor.theme)
            .systemFont(ofSize: 12)
            .textAlignment(.center)
            .cornerRadius(15)
            .masksToBounds(true)
            .borderColor(UIColor.theme)
            .borderWidth(1)
            .build
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubViews()
    }
    
    func update(model: BookListModel) {
        titleLabel.text = model.bookName
        subjectLabel.text = model.bookIntroduction
        if let ossUrl = model.ebBookResource.first?.ossUrl {
            imgView.kf.setImage(with: URL(string: ossUrl))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeHorizontalHasButtonCollectionCell {
    private func addSubViews() {
        backgroundColor = UIColor.clear
        contentView.addSubview(bgView)
        contentView.addSubview(imgView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subjectLabel)
        contentView.addSubview(readLabel)
        
        bgView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalTo(contentView.snp.bottom).offset(-12.hpx)
        }
        
        imgView.snp.makeConstraints { (make) in
            make.left.equalTo(bgView.snp.left).offset(16.wpx)
            make.top.equalTo(bgView.snp.top).offset(18.hpx)
            make.bottom.equalTo(bgView.snp.bottom).offset(-16.hpx)
            make.width.equalTo(92.wpx)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.snp.right).offset(15.wpx)
            make.top.equalTo(imgView.snp.top)
            make.right.equalTo(bgView.snp.right).offset(-15.wpx)
        }
        
        subjectLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(10.hpx)
            make.bottom.equalTo(bgView.snp.bottom).offset(-66.hpx)
        }
        
        readLabel.snp.makeConstraints { (make) in
            make.right.equalTo(bgView.snp.right).offset(-15.wpx)
            make.bottom.equalTo(bgView.snp.bottom).offset(-18.hpx)
            make.size.equalTo(CGSize(width: 80, height: 30))
        }
    }
}
