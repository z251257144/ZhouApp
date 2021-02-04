//
//  UIColor+Extension.swift
//  Alamofire
//
//  Created by zhoumin on 2019/8/14.
//

import Foundation
import UIKit

public extension UIColor {
    
    /// 获取颜色
    ///
    /// - Parameters:
    ///   - intRed: 0~255之前Red
    ///   - intGreen: 0~255之前Green
    ///   - intBlue: 0~255之前Blue
    ///   - alpha: 透明度，默认为1，不透明
    convenience init(intRed: UInt32, intGreen: UInt32, intBlue: UInt32, alpha: CGFloat = 1) {
        self.init(red: CGFloat(intRed)/255.0, green: CGFloat(intGreen)/255.0, blue: CGFloat(intBlue)/255.0, alpha: alpha)
    }

    /// 获取颜色，通过16进制色值字符串，e.g. #ff0000， ff0000, 0xff0000
    ///
    /// - Parameters:
    ///   - hex: 16进制字符串
    ///   - alpha: 透明度，默认为1，不透明
    convenience init(hex: String, alpha:CGFloat = 1) {
        // 去除空格等
        var hexString: String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        
        // 去除#
        if (hexString.hasPrefix("#")) {
            hexString = (hexString as NSString).substring(from:1)
        }
        
        // 去除0x
        if (hexString.hasPrefix("0X")) {
            hexString = (hexString as NSString).substring(from:2)
        }
        
        var rgbValue:UInt32 = 0
        if hexString.count==6 {
            Scanner(string:hexString).scanHexInt32(&rgbValue)
        }
        self.init(rgbValue: rgbValue)
    }
    
    /// 设置颜色与透明度 示例：0x26A7E8
    convenience init(rgbValue:UInt32, alpha: CGFloat = 1) {
        let r = (rgbValue & 0xFF0000) >> 16
        let g = (rgbValue & 0x00FF00) >> 8
        let b = (rgbValue & 0x0000FF)
        self.init(intRed: r, intGreen: g, intBlue: b, alpha: alpha)
    }
    
    /// 随机颜色
    ///
    /// - Returns: 颜色
    
    func randomColor() -> UIColor {
        let randomNumber = arc4random_uniform(UInt32(randomColorArray.count))
        return UIColor(hex: randomColorArray[Int(randomNumber)])
    }
}

let randomColorArray = ["009999", "0099cc", "0099ff", "00cc99", "00cccc", "336699", "3366cc", "3366ff", "339966", "666666", "666699", "6666cc", "6666ff", "996666", "996699", "999900", "999933", "99cc00", "99cc33", "660066", "669933", "990066", "cc9900", "cc6600" , "cc3300", "cc3366", "cc6666", "cc6699", "cc0066", "cc0033", "ffcc00", "ffcc33", "ff9900", "ff9933", "ff6600", "ff6633", "ff6666", "ff6699", "ff3366", "ff3333"]
