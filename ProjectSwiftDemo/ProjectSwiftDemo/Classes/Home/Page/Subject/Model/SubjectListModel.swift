//
//  SubjectListModel.swift
//  ProjectSwiftDemo
//
//  Created by 张书孟 on 2018/9/7.
//  Copyright © 2018年 zsm. All rights reserved.
//

struct SubjectListModel: Codable {
    let bookCode: String
    let bookName: String
    let tags: String
    let bookScore: String
    let bookIntroduction: String
    let isVip: String
    let ebBookResource: [EbBookModel]
}
