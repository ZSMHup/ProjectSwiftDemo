//
//  NetworkTools.swift
//
//  Created by 张书孟 on 2018/8/24.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import Foundation
import Alamofire

let kAppDebugAPiBaseUrl = "http://dev.ellabook.cn/open/api"
let kAppReleaseAPiBaseUrl = "http://api.ellabook.cn/rest/api/service"

enum Environment {
    case debug
    case release
}

class NetworkTools {
    
    static let `default` = NetworkTools()
    
    public var environment: Environment = .release
    
    private var baseURL: String = "http://dev.ellabook.cn/open/api"
    
    public func requestPostHanlder<T: Codable>(paramterDic: Dictionary<String, Any>,
                                               cache: Bool,
                                               model: T.Type,
                                               cacheCompletion: @escaping (T)->(),
                                               successCompletion: @escaping (T)->(),
                                               failureCompletion: @escaping (String)->()) {
        
        if environment == .debug {
            baseURL = kAppDebugAPiBaseUrl
        } else {
            baseURL = kAppReleaseAPiBaseUrl
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        timeoutIntervalForRequest(20)
        request(baseURL,
                method: .post,
                params: paramterDic)
            .cache(cache)
            .responseCacheAndData { (dataValue) in
                
                if !dataValue.isCacheData {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
                
                switch dataValue.result {
                case .success(let data):
                    if let responseData = try? JSONDecoder().decode(Network.Response<T>.self, from: data) {
                        
                        if !responseData.success {
                            failureCompletion(responseData.message)
                            return
                        }
                        
                        if dataValue.isCacheData {
                            cacheCompletion(responseData.data)
                        } else {
                            successCompletion(responseData.data)
                        }
                    }
                case .failure(let error):
                    failureCompletion(error.errorMessage)
                }
        }
    }
    
    public func uploadImage<T: Codable>(datas: [Data],
                                 model: T.Type,
                                 successCompletion: @escaping (T)->(),
                                 failureCompletion: @escaping (String)->()) {
        let url = "http://mis.v1.ubye.cn/api/upload/uploadOssBackgrd?subcatalog=image"
        
        RequestManager.default
            .upload(datas: datas,
                    url: url,
                    withName: "Filedata",
                    fileName: "\(UUID().uuidString).jpeg",
                mimeType: "image/jpeg",
                successCompletion: { (data) in
                    if let resopnseData = try? JSONDecoder().decode(Network.Response<T>.self, from: data) {
                        
                        if !resopnseData.success {
                            failureCompletion(resopnseData.message)
                            return
                        }
                        successCompletion(resopnseData.data)
                    } else {
                        failureCompletion("上传失败")
                    }
            }, progressCompletion: { (progress) in
                debugPrint("progress: \(progress)")
            }) { (error) in
                failureCompletion(error.errorMessage)
        }
    }
}


