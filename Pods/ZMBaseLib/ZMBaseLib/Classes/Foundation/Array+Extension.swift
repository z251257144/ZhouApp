//
//  Array+Extension.swift
//  Alamofire
//
//  Created by zhoumin on 2019/8/21.
//

import Foundation

extension Array {
    
    /// 判断不为空
    public var isNotEmpty: Bool {
        get {
            return !self.isEmpty
        }
    }
    
    /// 数组 json对象转换为字符串
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
}
