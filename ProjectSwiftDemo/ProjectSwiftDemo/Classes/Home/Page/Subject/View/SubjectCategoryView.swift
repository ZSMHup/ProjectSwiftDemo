//
//  SubjectCategoryView.swift
//  ProjectSwiftDemo
//
//  Created by 张书孟 on 2018/9/10.
//  Copyright © 2018年 zsm. All rights reserved.
//

import UIKit
import TagListView

class SubjectCategoryView: UIView {

    private lazy var backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.white
        return backgroundView
    }()
    
    private lazy var titleLabel: UILabel = {
        UILabel().chain
            .text("全部分类")
            .systemFont(ofSize: 16.fontpx)
            .textColor(UIColor.light)
            .build
    }()
    
    private lazy var tagListView: TagListView = {
        let tagListView = TagListView()
        tagListView.delegate = self
        tagListView.addTags(categoryTitles)
        tagListView.textFont = UIFont.systemFont(ofSize: 16.fontpx)
        tagListView.textColor = .light
        tagListView.tagBackgroundColor = .white
        tagListView.tagSelectedBackgroundColor = .theme
        tagListView.selectedTextColor = .white
        tagListView.borderColor = .light
        tagListView.borderWidth = 1
        tagListView.cornerRadius = 13
        tagListView.paddingX = 12
        tagListView.paddingY = 5
        tagListView.marginX = 12
        tagListView.marginY = 12
        return tagListView
    }()
    
    var didSelected: (SubjectTitleListModel) -> Void = { _ in }
    
    private var categoryArray: [SubjectTitleListModel] = [SubjectTitleListModel]()
    private var categoryTitles: [String] = [String]()
    convenience init(categoryArray: [SubjectTitleListModel]) {
        self.init()
        self.categoryArray = categoryArray
        
        for model in categoryArray {
            categoryTitles.append(model.wikiName)
        }
        
        backgroundColor = .white
        addSubViews()
    }
}

extension SubjectCategoryView {
    private func addSubViews() {
        
        addSubview(backgroundView)
        addSubview(titleLabel)
        addSubview(tagListView)
        
        backgroundView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(36.wpx)
            make.top.equalTo(self.snp.top).offset(17.hpx)
        }
        
        tagListView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(36.wpx)
            make.right.equalTo(self.snp.right).offset(-36.wpx)
            make.top.equalTo(self.snp.top).offset(47.hpx)
            make.bottom.equalToSuperview().offset(-16.hpx)
        }
    }
}

extension SubjectCategoryView: TagListViewDelegate {
    // MARK: TagListViewDelegate
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        for ta in sender.tagViews {
            if ta.titleLabel?.text == title {
                ta.isSelected = true
                
                let categorys = categoryArray.filter {
                    return $0.wikiName == title
                }
                
                if let model = categorys.first {
                    didSelected(model)
                }
                
            }else{
                ta.isSelected = false
            }
        }
    }
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        sender.removeTagView(tagView)
    }
}
