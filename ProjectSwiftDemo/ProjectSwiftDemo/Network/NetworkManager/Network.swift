//
//  Network.swift
//  SwiftTool
//
//  Created by zhangshumeng on 2018/8/25.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit
import CocoaDebug

class Network {
    
    struct Response<T: Codable>: Codable {
        let code: Int
        let status: Int
        let message: String
        let data: T
        
        var success: Bool {
            return code == 0 && status == 1
        }
        
        enum CodingKeys: String, CodingKey {
            case code
            case status
            case message
            case data
        }
    }
}

public func debugPrint<T>(file: String = #file, function: String = #function, line: Int = #line, _ message: T, color: UIColor = .white) {
    #if DEBUG
    swiftLog(file, function, line, message, color)
    #endif
}
