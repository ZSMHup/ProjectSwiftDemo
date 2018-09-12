//
//  HistoryRecModel.swift
//  ProjectSwiftDemo
//
//  Created by 张书孟 on 2018/9/11.
//  Copyright © 2018年 zsm. All rights reserved.
//

struct HistoryRecModel: Codable {
    let targetPage: String /// H5链接
    let dailyTitle: String /// 标题
    let dailyImg: String /// 封面图
    let effectDate: String /// 日期
}
