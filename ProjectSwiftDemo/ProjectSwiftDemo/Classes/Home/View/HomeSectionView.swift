//
//  HomeSectionView.swift
//  ProjectSwiftDemo
//
//  Created by 张书孟 on 2018/9/7.
//  Copyright © 2018年 zsm. All rights reserved.
//

import UIKit

class HomeSectionView: UICollectionReusableView {

    private lazy var bgView: UIView = { UIView() }()
    private lazy var lineView: UIView = { UIView() }()
    private lazy var titleLabel: UILabel = {
        UILabel().chain
            .textColor(UIColor.dark)
            .systemFont(ofSize: 20)
            .build
    }()
    private lazy var rightImgView: UIImageView = {
        UIImageView().chain
            .image(#imageLiteral(resourceName: "right_row"))
            .build
    }()
    
    private lazy var rightLabel: UILabel = {
        UILabel().chain
            .text("更多")
            .textColor(UIColor.light)
            .systemFont(ofSize: 16)
            .build
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.global
        addSubViews()
    }
    
    func update(model: HomeListModel) {
        titleLabel.text = model.partTitle
        rightLabel.text = model.targetDesc
        if model.partStyle == "SLIDE_PORTRAIT" {
            lineView.backgroundColor = UIColor(hex: "#FF984D")
        } else {
            lineView.backgroundColor = UIColor(hex: "#58C2ED")
        }
        
        if model.partStyle == "IMAGE_TEXT" {
            self.bgView.backgroundColor = UIColor.global
        } else {
            self.bgView.backgroundColor = UIColor.white
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeSectionView {
    private func addSubViews() {
        addSubview(bgView)
        addSubview(lineView)
        addSubview(titleLabel)
        addSubview(rightImgView)
        addSubview(rightLabel)
        
        bgView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(10.hpx)
            make.left.bottom.right.equalToSuperview()
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(36.wpx)
            make.bottom.equalTo(self.snp.bottom).offset(-12.hpx)
            make.size.equalTo(CGSize(width: 6, height: 19.5.hpx))
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(lineView.snp.right).offset(6.wpx)
            make.centerY.equalTo(lineView.snp.centerY)
        }
        
        rightImgView.snp.makeConstraints { (make) in
            make.centerY.equalTo(lineView.snp.centerY)
            make.right.equalTo(self.snp.right).offset(-36.wpx)
            make.size.equalTo(CGSize(width: 7, height: 11))
        }
        
        rightLabel.snp.makeConstraints { (make) in
            make.right.equalTo(rightImgView.snp.left).offset(-4)
            make.centerY.equalTo(lineView.snp.centerY)
        }
    }
}
