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
    
    let paramter = ["method": "ella.book.listSubject"]
    
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
    
    let paramter = ["method": "ella.book.listAllPart"]
    
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

func requestSubjectList(
    page: Int,
    sourceCode: String,
    cacheCompletion: @escaping ([SubjectListModel])->(),
    successCompletion: @escaping ([SubjectListModel])->(),
    failureCompletion: @escaping (String)->()) {
    
    let paramter = [
        "method": "ella.openPlatform.opListBookCommons",
        "content": convertDictionaryToString(dict: ["pageIndex": "\(page)",
                                                    "pageSize": "10",
                                                    "sourceCode": sourceCode,
                                                    "resource": "normal"])
        ] as [String : Any]
    
    
    NetworkTools.default.requestPostHanlder(paramterDic: paramter,
                                            cache: true,
                                            model: [SubjectListModel].self,
                                            cacheCompletion: { (caches) in
        cacheCompletion(caches)
    }, successCompletion: { (models) in
        successCompletion(models)
    }) { (error) in
        failureCompletion(error)
    }
}

func convertDictionaryToString(dict: [String: Any]) -> String {
    var result:String = ""
    do {
        //如果设置options为JSONSerialization.WritingOptions.prettyPrinted,则打印格式更好阅读
        let jsonData = try JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.init(rawValue: 0))
        if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
            result = JSONString
        }
    } catch {
        result = ""
    }
    return result
}
