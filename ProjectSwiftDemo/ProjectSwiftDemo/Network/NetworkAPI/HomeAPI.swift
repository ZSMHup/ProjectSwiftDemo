//
//  HomeAPI.swift
//  ProjectSwiftDemo
//
//  Created by 张书孟 on 2018/9/6.
//  Copyright © 2018年 zsm. All rights reserved.
//

import Foundation

/// 首页顶部功能
///
/// - Parameters:
///   - cacheCompletion: 缓存
///   - successCompletion: 成功回调
///   - failureCompletion: 失败回调
func requestHomeSubjectList(
    cacheCompletion: @escaping ([HomeSubjectListModel])->(),
    successCompletion: @escaping ([HomeSubjectListModel])->(),
    failureCompletion: @escaping (String)->()) {
    
    let paramter = ["method": "ella.book.listSubject",
                    "channelCode" : "kidsTools",]
    
    NetworkTools.default.requestPostHanlder(paramterDic: paramter,
                                            cache: true,
                                            model: [HomeSubjectListModel].self,
                                            cacheCompletion: { (caches) in
        cacheCompletion(caches)
    }, successCompletion: { (models) in
        successCompletion(models)
    }) { (error) in
        failureCompletion(error)
    }
}

/// 首页全部数据
///
/// - Parameters:
///   - cacheCompletion: 缓存
///   - successCompletion: 成功回调
///   - failureCompletion: 失败回调
func requestHomeAllList(
    cacheCompletion: @escaping ([HomeListModel])->(),
    successCompletion: @escaping ([HomeListModel])->(),
    failureCompletion: @escaping (String)->()) {
    
    let paramter = ["method": "ella.openPlatform.opAllPartList",
                    "channelCode" : "kidsTools",]
    
    NetworkTools.default.requestPostHanlder(paramterDic: paramter,
                                            cache: true,
                                            model: [HomeListModel].self,
                                            cacheCompletion: { (caches) in
         cacheCompletion(caches)
    }, successCompletion: { (models) in
        successCompletion(models)
    }) { (error) in
        failureCompletion(error)
    }
}

func requestHistoryRecList(
    page: Int,
    cacheCompletion: @escaping ([HistoryRecModel])->(),
    successCompletion: @escaping ([HistoryRecModel])->(),
    failureCompletion: @escaping (String)->()) {
    
    let paramter = [
        "channelCode" : "kidsTools",
        "method": "ella.book.listDailyBook",
        "content": ["pageIndex": page,
                    "pageSize": 10,
                    "listType": "LIST"].dictionaryToString
    ]
    
    NetworkTools.default.requestPostHanlder(paramterDic: paramter,
                                            cache: true,
                                            model: [HistoryRecModel].self,
                                            cacheCompletion: { (caches) in
                                                cacheCompletion(caches)
    }, successCompletion: { (models) in
        successCompletion(models)
    }) { (error) in
        failureCompletion(error)
    }
}

