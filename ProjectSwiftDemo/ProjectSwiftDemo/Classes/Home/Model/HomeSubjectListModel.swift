//
//  HomeSubjectListModel.swift
//  ProjectSwiftDemo
//
//  Created by 张书孟 on 2018/9/6.
//  Copyright © 2018年 zsm. All rights reserved.
//

struct HomeSubjectListModel: Codable {
    let subjectCode: String /// 专题编号
    let subjectTitle: String /// 专题标题
    let bgImageUrl: String ///  背景图片地址
    let bgImageUpUrl: String /// 背景图片图标地址
    let targetType: String /// 跳转的目标类型 BOOK_DETAIL:图书详情 ,H5:H5页面,SYSTEM_INTERFACE:系统界面 ,BOOK_LIST:图书列表页
    let targetPage: String /// 跳转内容
    let idx: String
}
