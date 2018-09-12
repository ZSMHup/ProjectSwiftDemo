//
//  Dictionary+Extension.swift
//  ProjectSwiftDemo
//
//  Created by 张书孟 on 2018/9/10.
//  Copyright © 2018年 zsm. All rights reserved.
//

import Foundation

extension Dictionary {
    
    /// 字典转jsonString
    var dictionaryToString: String {
        var result: String = ""
        do {
            //如果设置options为JSONSerialization.WritingOptions.prettyPrinted,则打印格式更好阅读
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.init(rawValue: 0))
            if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                result = JSONString
            }
        } catch {
            result = ""
        }
        return result
    }
}
