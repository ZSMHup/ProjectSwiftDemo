//
//  SubjectOtherCell.swift
//  ProjectSwiftDemo
//
//  Created by 张书孟 on 2018/9/10.
//  Copyright © 2018年 zsm. All rights reserved.
//

import UIKit
import Kingfisher

class SubjectOtherCell: UICollectionViewCell {
    
    private lazy var imgView: UIImageView = { UIImageView() }()
    
    private lazy var titleLabel: UILabel = {
        UILabel().chain
            .textColor(UIColor.dark)
            .systemFont(ofSize: 16.fontpx)
            .build
    }()
    
    private lazy var detailLabel: UILabel = {
        UILabel().chain
            .textColor(UIColor.light)
            .systemFont(ofSize: 12.fontpx)
            .numberOfLines(3)
            .build
    }()
    
    private lazy var starRating: StarRatingView = {
        let starRating = StarRatingView(frame: CGRect(x: 0, y: 0, width: 81, height: 15), numberOfStar: 5)
        starRating.rateStyle = .incompleteStar
        starRating.isEnabled = false
        return starRating
    }()
    
    private lazy var starRatingLabel: UILabel = {
        UILabel().chain
            .textColor(UIColor(hex: "#F59523"))
            .systemFont(ofSize: 16.fontpx)
            .build
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
     
        addSubViews()
    }
    
    func update(model: SubjectListModel) {
        if let ossUrl = model.ebBookResource.first?.ossUrl {
            imgView.kf.setImage(with: URL(string: ossUrl), placeholder: #imageLiteral(resourceName: "bigImage_placeholder"))
        }
        titleLabel.text = model.bookName
        detailLabel.text = model.bookIntroduction
        
        if let score: Float = Float(model.bookScore) {
            starRating.currentScore = score
            starRatingLabel.text = "\(score)分"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SubjectOtherCell {
    
    private func addSubViews() {
        contentView.addSubview(imgView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailLabel)
        contentView.addSubview(starRating)
        contentView.addSubview(starRatingLabel)
        
        imgView.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(16.wpx)
            make.top.equalTo(contentView.snp.top).offset(16.hpx)
            make.bottom.equalTo(contentView.snp.bottom).offset(-16.hpx)
            make.width.equalTo(109.wpx)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.snp.right).offset(12.wpx)
            make.top.equalTo(imgView.snp.top)
            make.right.equalTo(contentView.snp.right).offset(-16.wpx)
        }
        
        detailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.snp.right).offset(12.wpx)
            make.top.equalTo(titleLabel.snp.bottom).offset(41.hpx)
            make.right.equalTo(contentView.snp.right).offset(-16.wpx)
        }
        
        starRating.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.snp.right).offset(12.wpx)
            make.top.equalTo(detailLabel.snp.bottom).offset(9.hpx)
            make.size.equalTo(CGSize(width: 81, height: 15))
        }
        
        starRatingLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(starRating.snp.centerY)
            make.left.equalTo(starRating.snp.right).offset(12.wpx)
        }
    }
}
