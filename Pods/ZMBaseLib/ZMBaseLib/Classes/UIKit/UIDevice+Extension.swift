//
//  UIDevice+Extension.swift
//  Pods-ZMToolsLib_Example
//
//  Created by zhoumin on 2019/8/15.
//

import Foundation
import KeychainAccess


public extension UIDevice {
    
    /// 获取当前设备型号 e.g. iPhone 8 Plus
    ///
    /// - Returns: 设备型号
    func platformName() ->String {
        
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let platform = withUnsafePointer(to: &systemInfo.machine.0) { ptr in
            return String(cString: ptr)
        }
        
        //------------------------------iPhone---------------------------
        if platform == "iPhone5,1" { return "iPhone 5"}
        if platform == "iPhone5,2" { return "iPhone 5"}
        if platform == "iPhone5,3" { return "iPhone 5C"}
        if platform == "iPhone5,4" { return "iPhone 5C"}
        if platform == "iPhone6,1" { return "iPhone 5S"}
        if platform == "iPhone6,2" { return "iPhone 5S"}
        if platform == "iPhone8,4" { return "iPhone SE"}
        if platform == "iPhone7,2" { return "iPhone 6"}
        if platform == "iPhone7,1" { return "iPhone 6 Plus"}
        if platform == "iPhone8,1" { return "iPhone 6S"}
        if platform == "iPhone8,2" { return "iPhone 6S Plus"}
        if platform == "iPhone9,1" ||
           platform == "iPhone9,3" { return "iPhone 7"}
        if platform == "iPhone9,2" ||
           platform == "iPhone9,4" { return "iPhone 7 Plus"}
        if platform == "iPhone10,1" ||
           platform == "iPhone10,4" { return "iPhone 8"}
        if platform == "iPhone10,2" ||
           platform == "iPhone10,5" { return "iPhone 8 Plus"}
        if platform == "iPhone10,3" ||
           platform == "iPhone10,6" { return "iPhone X"}
        if platform == "iPhone11,8" { return "iPhone XR"}
        if platform == "iPhone11,2" { return "iPhone XS"}
        if platform == "iPhone11,4" ||
           platform == "iPhone11,6" { return "iPhone XS Max"}
        
        //------------------------------iPod Touch------------------------
        if platform == "iPod1,1" { return "iPod Touch 1G"}
        if platform == "iPod2,1" { return "iPod Touch 2G"}
        if platform == "iPod3,1" { return "iPod Touch 3G"}
        if platform == "iPod4,1" { return "iPod Touch 4G"}
        if platform == "iPod5,1" { return "iPod Touch 5G"}
        
        //------------------------------iPad--------------------------
        if platform == "iPad3,1" { return "iPad 3"}
        if platform == "iPad3,2" { return "iPad 3"}
        if platform == "iPad3,3" { return "iPad 3"}
        if platform == "iPad3,4" { return "iPad 4"}
        if platform == "iPad3,5" { return "iPad 4"}
        if platform == "iPad3,6" { return "iPad 4"}
        if platform == "iPad4,1" { return "iPad Air"}
        if platform == "iPad4,2" { return "iPad Air"}
        if platform == "iPad4,3" { return "iPad Air"}
        if platform == "iPad5,3" { return "iPad Air 2"}
        if platform == "iPad5,4" { return "iPad Air 2"}
        if platform == "iPad6,3" { return "iPad Pro 9.7"}
        if platform == "iPad6,4" { return "iPad Pro 9.7"}
        if platform == "iPad6,7" { return "iPad Pro 12.9"}
        if platform == "iPad6,8" { return "iPad Pro 12.9"}
        
        //------------------------------iPad Mini--------------------------
        if platform == "iPad2,5" { return "iPad Mini 1"}
        if platform == "iPad2,6" { return "iPad Mini 1"}
        if platform == "iPad2,7" { return "iPad Mini 1"}
        if platform == "iPad4,4" { return "iPad Mini 2"}
        if platform == "iPad4,5" { return "iPad Mini 2"}
        if platform == "iPad4,6" { return "iPad Mini 2"}
        if platform == "iPad4,7" { return "iPad Mini 3"}
        if platform == "iPad4,8" { return "iPad Mini 3"}
        if platform == "iPad4,9" { return "iPad Mini 3"}
        if platform == "iPad5,1" { return "iPad Mini 4"}
        if platform == "iPad5,2" { return "iPad Mini 4"}
        
        //------------------------------Samulitor----------------------
        if platform == "i386" ||
           platform == "x86_64" { return "iPhone Simulator"}
        
        return platform
    }
    
    
    /// 获取当前系统型号 e.g. iOS 10.3
    ///
    /// - Returns: 系统型号
    func systemFullString() -> String {
        return self.systemName + " " + self.systemVersion
    }
    
    /// 获取当前设备序列号
    ///
    /// - Returns: 设备序列号
    static func uuid() -> String {
        let uuidKey = Bundle.bundleID + ".uuid"
        
        let keychain = Keychain(service: uuidKey)
        var uuidString = keychain[uuidKey]
        
        if uuidString == nil {
            var uuidObject = UIDevice.current.identifierForVendor
            if uuidObject == nil {
                uuidObject = UUID()
            }
            uuidString = uuidObject!.uuidString
            
            keychain[uuidKey] = uuidString!
        }
        
        return uuidString!
    }
    
    /// 判断当前设备是不是iPhone设备
    static func isIPhone() -> Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone
    }
    
    /// 判断当前设备是不是iPad设备
    static func isIPad() -> Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
    }
}

/**
 e.g:
 if SystemVersion.greaterThan("10.0") {
 
 }
 
 if #available(iOS 10.0, *) {
 
 }
 */
// MARK: 判断系统版本
public extension UIDevice {
    /// 判断当前系统版本
    ///
    /// - Parameter version: 版本
    /// - Returns: 比较结果
    static func compare(_ version: String) -> ComparisonResult {
        return UIDevice.current.systemVersion.compare(version, options: NSString.CompareOptions.numeric)
    }
    
    static func equal(_ version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version, options: NSString.CompareOptions.numeric) == .orderedSame
    }
    
    static func greaterThan(_ version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version, options: NSString.CompareOptions.numeric) == .orderedDescending
    }
    
    static func greaterThanOrEqual(_ version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version, options: NSString.CompareOptions.numeric) != .orderedAscending
    }
    
    static func lessThan(_ version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version, options: NSString.CompareOptions.numeric) == .orderedAscending
    }
    
    static func lessThanOrEqual(_ version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version, options: NSString.CompareOptions.numeric) != .orderedDescending
    }
}


public enum DeviceType: Int
{
    case unknown = 0
    case iPhone4            //iPhone4、iPhone4S
    case iPhone5            //iPhone5、iPhone5C和iPhone5S
    case iPhone6            //iPhone6、iPhone6S、iPhone7
    case iPhone6_Plus       //iPhone6 Plus、iPhone6S Plus、iPhone7 Plus
    case iPhone_X           //iPhoneX、iPhoneXS
    case iPhone_XR          //iPhoneXR
    case iPhone_XS_Max      //iPhoneXS Max
    case iPad               //iPad1、iPad2(1024*768)
    case iPad_Retina        //iPad4和iPad Air
    case iPad_12_9_Inch     //iPad Pro 12.9
    case iPad_10_5_Inch     //iPad Pro 10.5
}

public extension UIDevice {
    
    /// 根据屏幕分辨率判断设备类型
    static var deviceType: DeviceType {
        guard let size = UIScreen.main.currentMode?.size else {
            return .unknown
        }
        
        let height = max(size.width, size.height)
        
        switch height {
            case 960.0: return  .iPhone4
            case 1136.0: return .iPhone5
            case 1334.0: return .iPhone6
            case 2208.0: return .iPhone6_Plus
            case 2436.0: return .iPhone_X
            case 1792.0: return .iPhone_XR
            case 1624.0: return .iPhone_XR
            case 2688.0: return .iPhone_XS_Max
            case 1024.0: return .iPad
            case 2048.0: return .iPad_Retina
            case 2732.0: return .iPad_12_9_Inch
            case 2224.0: return .iPad_10_5_Inch
            default: return .unknown
        }
    }
    
    /// 判断当前设备屏幕是不是iPhone4
    static let isIPhone4: Bool = UIDevice.deviceType == .iPhone4
    
    /// 判断当前设备屏幕是不是iPhone5
    static let isIPhone5: Bool = UIDevice.deviceType == .iPhone5
    
    ///  判断当前设备屏幕是不是iPhone6
    static let isIPhone6: Bool = UIDevice.deviceType == .iPhone6
    
    /// 判断当前设备屏幕是不是iPhone6 Plus
    static let isIPhone6Plus: Bool = UIDevice.deviceType == .iPhone6_Plus
    
    /// 判断当前设备屏幕是不是iPhoneX
    static let isIPhoneX: Bool = UIDevice.deviceType == .iPhone_X
    
    /// 判断当前设备屏幕是不是iPhoneXR
    static let isIPhoneXR: Bool = UIDevice.deviceType == .iPhone_XR
    
    /// 判断当前设备屏幕是不是iPhoneXS Max
    static let isIPhoneXSMax: Bool = UIDevice.deviceType == .iPhone_XS_Max
    
    /// 判断当前设备屏幕是不是刘海屏
    static let isIPhoneX_All: Bool = UIDevice.isIPhoneX || UIDevice.isIPhoneXR || UIDevice.isIPhoneXSMax
    
    /// 状态栏的高度
    static let statusBarHeight: CGFloat = UIDevice.isIPhoneX_All ? 44.0 : 20.0
    
    ///  navigation bar height(包含Status bar)
    static let navigationBarHeight: CGFloat = UIDevice.isIPhoneX_All ? 88.0 : 64.0
    
    /// Tabbar safe bottom margin.
    static let tabbarSafeBottomMargin: CGFloat = (UIDevice.isIPhoneX_All ? 34.0 : 0.0)
    
    /// Tabbar height.
    static let tabbarHeight: CGFloat = (49.0 + UIDevice.tabbarSafeBottomMargin)

}

