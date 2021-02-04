//
//  Dictionary+Extension.swift
//  Alamofire
//
//  Created by zhoumin on 2019/8/21.
//

import Foundation

extension Dictionary {
    
    /// 字典 json对象转换为字符串
    ///
    /// - Returns: 字符串
    public func toJsonString() -> String? {
        if !JSONSerialization.isValidJSONObject(self) {
            return nil
        }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: self)
            return String(data: data, encoding: String.Encoding.utf8)
        }
        catch {
            logging(error)
        }
        
        return nil
    }
    
    /// 检查字典是否含有指定的key
    ///
    /// - Parameter key: 指定的key
    /// - Returns: 检查结果
    public func contains(key: Key) -> Bool {
        return self[key] != nil
    }
    
    /// 字典合并
    ///
    /// - Parameter dict
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            self.updateValue(v, forKey: k)
        }
    }
}


