//
//  NetworkTools.swift
//
//  Created by 张书孟 on 2018/8/24.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import Foundation
import Alamofire

let kAppDebugAPiBaseUrl = "http://test.mis.ubye.cn/m/"
let kAppReleaseAPiBaseUrl = "http://mis.v1.ubye.cn/m/"

enum Environment {
    case debug
    case release
}

class NetworkTools {
    
    static let `default` = NetworkTools()
    
    public var environment: Environment = .debug
    
    private var baseURL: String = "http://test.mis.ubye.cn/m/"
    
    public func requestUbyeHanlder<T: Codable>(
        url: String,
        paramterDic: Dictionary<String, Any>,
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
        
        let urlString = baseURL + url
        let params: [String : Any] = [
            "sign": "",
            "body": paramterDic
        ]
        let headers: HTTPHeaders = [
            "Authorization": "eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJhYWM4MDliNC04YzQ3LTRiMTgtYjhiMi1mZmZmNTlmMzFiY2IiLCJpYXQiOjE1MzYxMzI1MDEsImlzcyI6IkFkaW5uZXQiLCJzdWIiOiIzOTYifQ.p0hCrz_drTk9Ny4x6bg3ePr3j_lv2D2lKDBVYMI6bJI"
        ]
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        timeoutIntervalForRequest(20)
        request(urlString,
                method: .post,
                params: params,
                encoding: Alamofire.JSONEncoding.default,
                headers: headers)
            .cache(cache)
            .responseCacheAndData { (dataValue) in
                
                if !dataValue.isCacheData {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
                
                switch dataValue.result {
                case .success(let data):
                    if let responseData = try? JSONDecoder().decode(Network.Response<T>.self, from: data) {
                        debugPrint(responseData.message, responseData.code)
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


