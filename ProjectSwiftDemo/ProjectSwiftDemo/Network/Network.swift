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
        let message: String
        let data: T
        let token: String
        
        var success: Bool {
            return code == 2000
        }
        
        enum CodingKeys: String, CodingKey {
            case code
            case message
            case data = "result"
            case token
        }
    }
}

public func debugPrint<T>(file: String = #file, function: String = #function, line: Int = #line, _ message: T, color: UIColor = .white) {
    #if DEBUG
    swiftLog(file, function, line, message, color)
    #endif
}
