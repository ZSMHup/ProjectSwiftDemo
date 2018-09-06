//
//  HomeListModel.swift
//  ProjectSwiftDemo
//
//  Created by 张书孟 on 2018/9/6.
//  Copyright © 2018年 zsm. All rights reserved.
//

struct HomeListModel: Codable {
    let partCode: String /// 栏目编号
    let partTitle: String /// 栏目标题
    let partStyle: String /// DAILY_BOOK, IMAGE_TEXT, SLIDE_HORIZONTAL: 手动列表; SLIDE_PORTRAIT: 自动列表
    let partType: String ///
    let partSource: String /// 展示数据地址
    let partSourceNum: String /// 展示数量
    let targetType: String /// 跳转的目标类型 BOOK_DETAIL:图书详情 ,H5:H5页面,SYSTEM_INTERFACE:系统界面 ,BOOK_LIST:图书列表页
    let targetDesc: String /// 查看全部 跳转描述
    let targetPage: String /// 查看全部 跳转URL
    let idx: String /// 排序号
    let dailyList: [DailyListModel] /// 每日绘本图书列表
    let bookList: [BookListModel] /// 图书列表
}

struct DailyListModel: Codable {
    let dailyCode: String ///
    let dailyTitle: String /// 标题
    let dailyImg: String /// 封面图
    let targetPage: String /// H5详情页面
}

struct BookListModel: Codable {
    let bookCode: String /// 图书编号
    let bookName: String /// 图书名称
    let bookIntroduction: String /// 图书简介
    let bookScore: String /// 图书评分
    let bookScoreFormatter: String ///
    let scoreNum: String /// 评分人数
    let bookPressName: String /// 系列名称
    let downloadNum: String /// 下载次数
    let readNum: String /// 阅读人数
    let realReadNum: String ///
    let buyNum: String ///
    let isVip: String /// 是否会员借阅 VIP_NO-否 VIP_YES-是
    let ebBookResource: [EbBookModel] ///  图书资源
}

struct EbBookModel: Codable {
    let bookCode: String
    let resourceType: String /// 模式类型 BOOK_COVER:图书封面,BOOK_TRY_READ:试读
    let resource: String /// 设备型号 normal
    let ossUrl: String /// 资源地址
    let statu: String /// 可用状态 EXCEPTION:不可用 ,NORMAL:可用
    let isDefault: String /// 是否默认资源 DEFAULT_NO:否 ,DEFAULT_YES:是
    let resourceVersion: String /// 资源版本
}
