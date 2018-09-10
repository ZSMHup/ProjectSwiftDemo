//
//  SubjectAPI.swift
//  ProjectSwiftDemo
//
//  Created by 张书孟 on 2018/9/10.
//  Copyright © 2018年 zsm. All rights reserved.
//

func requestSubjectList(
    page: Int,
    sourceCode: String,
    cacheCompletion: @escaping ([SubjectListModel])->(),
    successCompletion: @escaping ([SubjectListModel])->(),
    failureCompletion: @escaping (String)->()) {
    
    let paramter = [
        "channelCode" : "kidsTools",
        "method": "ella.openPlatform.opListBookCommons",
        "content": ["pageIndex": page,
                    "pageSize": 10,
                    "sourceCode": sourceCode,
                    "resource": "normal"].dictionaryToString
    ]
    
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

func requestSubjectAllList(
    page: Int,
    wikiCode: String,
    cacheCompletion: @escaping ([BookListModel])->(),
    successCompletion: @escaping ([BookListModel])->(),
    failureCompletion: @escaping (String)->()) {
    
    let paramter = [
        "channelCode" : "kidsTools",
        "method": "ella.book.listBookByWiki",
        "content": ["pageIndex": page,
                    "pageSize": 10,
                    "wikiCode": wikiCode,
                    "resource": "normal"].dictionaryToString
    ]
    
    NetworkTools.default.requestPostHanlder(paramterDic: paramter,
                                            cache: true,
                                            model: [BookListModel].self,
                                            cacheCompletion: { (caches) in
                                                cacheCompletion(caches)
    }, successCompletion: { (models) in
        successCompletion(models)
    }) { (error) in
        failureCompletion(error)
    }
}

func requestSubjectAllTitleList(
    successCompletion: @escaping ([SubjectTitleListModel])->(),
    failureCompletion: @escaping (String)->()) {
    
    let paramter = [
        "channelCode" : "kidsTools",
        "method": "ella.book.listBookWikiAll"
    ]
    
    NetworkTools.default.requestPostHanlder(paramterDic: paramter,
                                            cache: false,
                                            model: [SubjectTitleListModel].self,
                                            cacheCompletion: { (caches) in
    }, successCompletion: { (models) in
        successCompletion(models)
    }) { (error) in
        failureCompletion(error)
    }
}
