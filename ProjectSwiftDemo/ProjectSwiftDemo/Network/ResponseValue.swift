//
//  ResponseValue.swift
//
//  Created by 张书孟 on 2018/8/24.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import Alamofire

//// MARK: - Result
public struct ResponseValue<Value> {
    public let isCacheData: Bool
    public let result: Alamofire.Result<Value>
    public let response: HTTPURLResponse?
    init(isCacheData: Bool, result: Alamofire.Result<Value>, response: HTTPURLResponse?) {
        self.isCacheData = isCacheData
        self.result = result
        self.response = response
    }
}

