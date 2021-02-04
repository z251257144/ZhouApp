//
//  Bundle+Extension.swift
//  Alamofire
//
//  Created by zhoumin on 2019/8/21.
//

import Foundation

extension Bundle {
    
    /// 获取当前app版本号
    public static var appVersion: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
    
    /// 获取当前app名称
    public static var appName: String {
        return Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? ""
    }
    
    /// 获取当前app bundleID
    public static var bundleID: String {
        return Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String ?? ""
    }
    
    /// 获取当前app CFBundleName
    public static var bundleName: String {
        return Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
    }
}
