//
//  Data+Extension.swift
//  Alamofire
//
//  Created by ZhouMin on 2019/8/21.
//

import Foundation

extension Data {
    /// 数据转换为Json对象
    ///
    /// - Returns: Json对象
    func toJsonObject() -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: self, options: JSONSerialization.ReadingOptions.allowFragments)
        }
        catch {
            logging(error)
        }
        
        return nil
    }
}
