//
//  String+Extension.swift
//  MICSupplier
//
//  Created by zhoumin on 2018/3/2.
//  Copyright © 2018年 songshanping. All rights reserved.
//

import Foundation

public extension String {
    
    /// 判断不为空
    var isNotEmpty: Bool {
        get {
            return !self.isEmpty
        }
    }
    
    /// 是否包含给定的字符串
    ///
    /// - Parameter string: 给定的字符串
    /// - Returns: 检查结果
    func contains(string: String) -> Bool{
        return self.range(of: string) != nil
    }
    
    /**
     截取字符串至指定位置
     
     ### Usage Example: ###
     `````
     let string: String = "Hello World!"
     print(string.substring(to: 4)) // Hello
     `````
     
     - Parameter to: 截取位置
     - Returns: 子字符串
     */
    func substring(to: Int) -> String {
        guard 0..<count ~= to else { return self }
        return String(self[...self.index(self.startIndex, offsetBy: to)])
    }
    
    /**
     从指定位置开始截取字符串
     
     ### Usage Example: ###
     `````
     let string: String = "Hello World!"
     print(string.substring(from: 6)) // World!
     `````
     
     - Parameter from: 截取位置
     - Returns: 子字符串
     */
    func substring(from: Int) -> String {
        guard 0...count ~= from else { return self }
        return String(self[self.index(self.startIndex, offsetBy: from)...])
    }
    
    /// 计算字符串的显示高度
    ///
    /// - Parameters:
    ///   - width: 显示范围宽度
    ///   - font: 显示字体
    /// - Returns: 高度
    func layoutHeight(width: CGFloat, font: UIFont) -> CGFloat {
        return self.layoutSize(width: width, font: font).height
    }
    
    /// 计算字符串的显示范围
    ///
    /// - Parameters:
    ///   - width: 显示范围宽度
    ///   - font: 显示字体
    /// - Returns: 显示范围
    func layoutSize(width: CGFloat, font: UIFont) -> CGSize {
        if width<=0 {
            return CGSize.zero
        }
        
        let constraintRect = CGSize(width: width, height: 99999)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.size
    }
    
    /// 转化为日期
    ///
    /// - Parameter dateFormat: 格式化样式,默认“yyyy-MM-dd HH:mm:ss”
    /// - Returns: 日期
    func toDate(dateFormat:String = sDateFormat_Default) -> Date? {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = dateFormat
        return formatter.date(from: self)
    }
    
    /// 字符串转换为Json对象
    ///
    /// - Returns: Json对象
    func toJsonObject(_ encode: String.Encoding = .utf8) -> Any? {
        guard let data = self.data(using: encode) else {
            return nil
        }
        
        return data.toJsonObject()
    }
}

public extension String {
    
    //将原始的url编码为合法的url
    func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
    
    //将编码后的url转换回原始的url
    func urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }
}
