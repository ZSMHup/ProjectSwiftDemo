//
//  CacheManager.swift
//
//  Created by 张书孟 on 2018/8/24.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import Cache

struct CacheModel: Codable {
    var data: Data?
    var dataDict: Dictionary<String, Data>?
    init() {}
}

class CacheManager {
    static let `default` = CacheManager()
    /// Manage storage
    private var storage: Storage<CacheModel>?
    /// init
    init() {
        let diskConfig = DiskConfig(name: "NetCache")
        let memoryConfig = MemoryConfig(expiry: .never)
        do {
            storage = try Storage(diskConfig: diskConfig, memoryConfig: memoryConfig, transformer: TransformerFactory.forCodable(ofType: CacheModel.self))
        } catch {
            debugPrint(error)
        }
    }
    /// 清除所有缓存
    ///
    /// - Parameter completion: 完成闭包
    func removeAllCache(completion: @escaping (Bool)->()) {
        storage?.async.removeAll(completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .value: completion(true)
                case .error: completion(false)
                }
            }
        })
    }
    /// 根据key值清除缓存
    func removeObjectCache(_ cacheKey: String, completion: @escaping (Bool)->()) {
        storage?.async.removeObject(forKey: cacheKey, completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .value: completion(true)
                case .error: completion(false)
                }
            }
        })
    }
    /// 异步读取缓存
    func object(forKey key: String, completion: @escaping (Cache.Result<CacheModel>)->Void) {
        storage?.async.object(forKey: key, completion: completion)
    }
    /// 读取缓存
    func objectSync(forKey key: String) -> CacheModel? {
        do {
            return (try storage?.object(forKey: key)) ?? nil
        } catch {
            return nil
        }
    }
    /// 异步存储
    func setObject(_ object: CacheModel, forKey: String) {
        storage?.async.setObject(object, forKey: forKey, completion: { _ in
        })
    }
    
//    func getFileSize() -> Double  {
//        var size: Double = 0
//        let fileManager = FileManager.default
//        var isDir: ObjCBool = false
//        let isExists = fileManager.fileExists(atPath: filePath!, isDirectory: &isDir)
//        // 判断文件存在
//        if isExists {
//            // 是否为文件夹
//            if isDir.boolValue {
//                // 迭代器 存放文件夹下的所有文件名
//                let enumerator = fileManager.enumerator(atPath: filePath!)
//                for subPath in enumerator! {
//                    // 获得全路径
//                    let fullPath = filePath?.appending("/\(subPath)")
//                    do {
//                        let attr = try fileManager.attributesOfItem(atPath: fullPath!)
//                        size += attr[FileAttributeKey.size] as! Double
//                    } catch  {
//                        debugPrint("error :\(error)")
//                    }
//                }
//            } else {    // 单文件
//                do {
//                    let attr = try fileManager.attributesOfItem(atPath: filePath!)
//                    size += attr[FileAttributeKey.size] as! Double
//
//                } catch  {
//                    debugPrint("error :\(error)")
//                }
//            }
//        }
//        return size
//    }
}


