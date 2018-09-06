//
//  String+Extension.swift
//
//  Created by zhangshumeng on 2018/8/25.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

/// 计算高度
public extension String {
    
    func textHeight(font: UIFont, width: CGFloat, maxHeight: CGFloat = CGFloat.greatestFiniteMagnitude) -> CGFloat {
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: maxHeight),
                                                       options: .usesLineFragmentOrigin,
                                                       attributes: [.font: font],
                                                       context: nil)
        return ceil(rect.height)
    }
    
    func get_heightForComment(fontSize: CGFloat, width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(rect.height)
    }
}

public extension String {
    
    func urlEncoding() -> String {
        if self.isEmpty { return "" }
        return CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, self as CFString, "!$&'()*+,-./:;=?@_~%#[]" as CFString, nil, CFStringBuiltInEncodings.UTF8.rawValue) as String
    }
    
    func urlDecoding() -> String {
        if self.isEmpty { return "" }
        guard let decodingUrl = self.removingPercentEncoding else { return "" }
        return decodingUrl
    }
}

/// 日期
public extension String {
    
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let formatDate = dateFormatter.date(from: self) else { return "" }
        let calendar = Calendar.current
        _ = calendar.component(.era, from: formatDate)
        let year = calendar.component(.year, from: formatDate)
        let month = calendar.component(.month, from: formatDate)
        let day = calendar.component(.day, from: formatDate)
        let hour = calendar.component(.hour, from: formatDate)
        let minute = calendar.component(.minute, from: formatDate)
        let second = calendar.component(.second, from: formatDate)
        return String(format: "%.2zd年%.2zd月%.2zd日 %.2zd时:%.2zd分:%.2zd秒", year, month, day, hour, minute, second)
    }
    
    func featureWeekday() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let formatDate = dateFormatter.date(from: self) else { return "" }
        let calendar = Calendar.current
        let weekDay = calendar.component(.weekday, from: formatDate)
        switch weekDay {
        case 1:
            return "星期日"
        case 2:
            return "星期一"
        case 3:
            return "星期二"
        case 4:
            return "星期三"
        case 5:
            return "星期四"
        case 6:
            return "星期五"
        case 7:
            return "星期六"
        default:
            return ""
        }
    }
}

/// emoji表情处理
public extension String {
    // 判断是否包含emoji
    var containsEmoji: Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case
            0x00A0...0x00AF,
            0x2030...0x204F,
            0x2120...0x213F,
            0x2190...0x21AF,
            0x2310...0x329F,
            0x1F000...0x1F9CF:
                return true
            default:
                continue
            }
        }
        return false
    }
    
    //返回字数
    private var count: Int {
        let string_NS = self as NSString
        return string_NS.length
    }
    
    //使用正则表达式替换
    private func pregReplace(pattern: String, with: String,
                     options: NSRegularExpression.Options = []) -> String {
        let regex = try! NSRegularExpression(pattern: pattern, options: options)
        return regex.stringByReplacingMatches(in: self, options: [],
                                              range: NSMakeRange(0, self.count),
                                              withTemplate: with)
    }
    
    // 移除emoji
    func removeEmoji() -> String {
        let pattern = "[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"
        return self.pregReplace(pattern: pattern, with: "")
    }
}

/// 版本更新
public extension String {
    /// 获取当前版本号
    var appVersion: String {
        guard let infoDic = Bundle.main.infoDictionary else { return "" }
        let appVersion: String = (infoDic["CFBundleShortVersionString"] ?? "") as! String
        return appVersion
    }
    
    /// 比较版本号
    func versionCompare() -> Bool {
        let result = appVersion.compare(self, options: .numeric, range: nil, locale: nil)
        if result == .orderedDescending || result == .orderedSame{
            return false
        }
        return true
    }
}
