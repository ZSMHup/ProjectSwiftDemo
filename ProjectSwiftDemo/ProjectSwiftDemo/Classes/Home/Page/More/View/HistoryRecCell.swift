//
//  HistoryRecCell.swift
//  ProjectSwiftDemo
//
//  Created by 张书孟 on 2018/9/12.
//  Copyright © 2018年 zsm. All rights reserved.
//

import UIKit

class HistoryRecCell: UITableViewCell {

    private lazy var dateLabel: UILabel = {
        UILabel().chain
            .textColor(UIColor.dark)
            .systemFont(ofSize: 16.fontpx)
            .textAlignment(.center)
            .backgroundColor(UIColor.global)
            .build
    }()
    
    private lazy var imgView: UIImageView = { UIImageView() }()
    
    private lazy var titleLabel: UILabel = {
        UILabel().chain
            .textColor(UIColor.dark)
            .systemFont(ofSize: 14.fontpx)
            .build
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        
        addSubViews()
    }
    
    func update(model: HistoryRecModel) {
        dateLabel.text = model.effectDate
        imgView.kf.setImage(with: URL(string: model.dailyImg))
        titleLabel.text = model.dailyTitle
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HistoryRecCell {
    private func addSubViews() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(imgView)
        contentView.addSubview(titleLabel)
        
        dateLabel.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(44.hpx)
        }
        
        imgView.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(36.wpx)
            make.right.equalTo(contentView.snp.right).offset(-36.wpx)
            make.top.equalTo(dateLabel.snp.bottom).offset(20.hpx)
            make.height.equalTo((UIScreen.width - 72.wpx) * (324.5 / 696))
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(36.wpx)
            make.right.equalTo(contentView.snp.right).offset(-36.wpx)
            make.top.equalTo(imgView.snp.bottom).offset(20.hpx)
            make.bottom.equalTo(contentView.snp.bottom).offset(-20.hpx)
        }
    }
}

extension HistoryRecCell {
    
}
