//
//  HomeHorizontalCollectionCell.swift
//  ProjectSwiftDemo
//
//  Created by 张书孟 on 2018/9/7.
//  Copyright © 2018年 zsm. All rights reserved.
//

import UIKit

class HomeHorizontalCollectionCell: UICollectionViewCell {
    
    lazy var imgView: UIImageView = { UIImageView() }()
    
    lazy var subjectLabel: UILabel = {
        UILabel().chain
            .textColor(UIColor.dark)
            .systemFont(ofSize: 14.fontpx)
            .numberOfLines(2)
            .build
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imgView)
        contentView.addSubview(subjectLabel)
        
        imgView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(214.5.hpx)
        }
        
        subjectLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(imgView)
            make.top.equalTo(imgView.snp.bottom).offset(12.hpx)
        }
    }
    
    func updateSlidePro(model: BookListModel) {
        
        subjectLabel.text = model.bookName
        if let ossUrl = model.ebBookResource.first?.ossUrl {
            imgView.kf.setImage(with: URL(string: ossUrl), placeholder: #imageLiteral(resourceName: "bigImage_placeholder"))
        }
    }
    
    func updateMore(model: SubjectListModel) {
        subjectLabel.text = model.bookName
        if let ossUrl = model.ebBookResource.first?.ossUrl {
            imgView.kf.setImage(with: URL(string: ossUrl), placeholder: #imageLiteral(resourceName: "bigImage_placeholder"))
        }
    }

    func update(model: BookListModel) {
        imgView.snp.updateConstraints { (make) in
            make.height.equalTo(126.hpx)
        }
        subjectLabel.text = model.bookName
        
        if let ossUrl = model.ebBookResource.first?.ossUrl {
            imgView.kf.setImage(with: URL(string: ossUrl), placeholder: #imageLiteral(resourceName: "bigImage_placeholder"))
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
