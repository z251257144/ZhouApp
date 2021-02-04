//
//  Date+Extension.swift
//  Alamofire
//
//  Created by zhoumin on 2019/8/14.
//

import Foundation
import UIKit

public let sDateFormat_Default  = "yyyy-MM-dd HH:mm:ss"
public let sDateFormat_YMD      = "yyyy-MM-dd"
public let sDateFormat_YMD_zh   = "yyyy年MM月dd日"
public let sDateFormat_YMD_Hms_S = "yyyy-MM-dd HH:mm:ss.SSS"

public extension Date {
    
    // MARK: Getter
    // Date year
    var year : Int {
        get {
            return self.getComponent(.year).year ?? 0
        }
    }
    
    // Date month
    var month : Int {
        get {
            return self.getComponent(.month).month ?? 0
        }
    }
    
    // Date days
    var day : Int {
        get {
            return self.getComponent(.day).day ?? 0
        }
    }
    
    // Date hours
    var hour : Int {
        get {
            return self.getComponent(.hour).hour ?? 0
        }
    }
    
    // Date minuts
    var minute : Int {
        get {
            return self.getComponent(.minute).minute ?? 0
        }
    }
    
    // Date seconds
    var second : Int {
        get {
            return self.getComponent(.second).second ?? 0
        }
    }
    
    /// 获取日期的DateComponents
    ///
    /// - Parameter component: Calendar.Component类型
    /// - Returns: DateComponents对象
    func getComponent(_ component:Calendar.Component) -> DateComponents {
        return NSCalendar.current.dateComponents([component], from: self)
    }
    
    // MARK: 调整时间
    /// 增减年份间隔
    ///
    /// - Parameter years: 年份间隔
    /// - Returns: 日期
    func addYears(_ years: Int) -> Date {
        return self.adding(.year, value: years)
    }
    
    /// 增减月份间隔
    ///
    /// - Parameter months: 月份间隔
    /// - Returns: 日期
    func addMonths(_ months: Int) -> Date {
        return self.adding(.month, value: months)
    }
    
    /// 增减天数间隔
    ///
    /// - Parameter days: 天数间隔
    /// - Returns: 日期
    func addDays(_ days: Int) -> Date {
        return self.adding(.day, value: days)
    }
    
    /// 增减小时间隔
    ///
    /// - Parameter hours: 小时间隔
    /// - Returns: 日期
    func addHours(_ hours: Int) -> Date {
        return self.adding(.hour, value: hours)
    }
    
    /// 增减分钟数
    ///
    /// - Parameter minutes: 分钟间隔
    /// - Returns: 日期
    func addMinutes(_ minutes: Int) -> Date {
        return self.adding(.minute, value: minutes)
    }
    
    /// 增减秒数
    ///
    /// - Parameter seconds: 秒间隔
    /// - Returns: 日期
    func addSeconds(_ seconds: Int) -> Date {
        return self.adding(.second, value: seconds)
    }
    
    /// 调整时间
    ///     let date = Date() // "Jan 12, 2017, 7:07 PM"
    ///     let date2 = date.adding(.minute, value: -10) // "Jan 12, 2017, 6:57 PM"
    ///     let date3 = date.adding(.day, value: 4) // "Jan 16, 2017, 7:07 PM"
    ///     let date4 = date.adding(.month, value: 2) // "Mar 12, 2017, 7:07 PM"
    ///     let date5 = date.adding(.year, value: 13) // "Jan 12, 2030, 7:07 PM
    ///
    /// - Parameters:
    ///   - component: Calendar.Component类型
    ///   - value: 日期间隔
    /// - Returns: 日期
    func adding(_ component: Calendar.Component, value: Int) -> Date {
        return Calendar.current.date(byAdding: component, value: value, to: self)!
    }
}

public extension Date {
    /// 日期所在月份第一天
    func firstMonthDate() -> Date {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents(
            Set<Calendar.Component>([.year, .month]), from: self)
        let firstDate = calendar.date(from: components)!
        return firstDate
    }

    
    /// 日期所在月份最后一天
    /// - Parameter needTime: 是否显示时间（23：59：59）
    func endMonthDate(needTime:Bool = false) -> Date {
        let firstMonthDate = self.firstMonthDate()
        
        let calendar = NSCalendar.current
        var components = DateComponents()
        components.month = 1
        if needTime {
            components.second = -1
        }
        else {
            components.day = -1
        }
        
        let endDate = calendar.date(byAdding: components, to: firstMonthDate)!
        return endDate
    }
    
    
    /// 比较日期是否在同一天
    /// - Parameter otherDate: 日期
    func isSameDay(otherDate: Date) -> Bool {
        return self.year == otherDate.year
            && self.month == otherDate.month
            && self.day == otherDate.day
    }
    
    /// 比较日期是否在同月
    /// - Parameter otherDate: 日期
    func isSameMonth(otherDate: Date) -> Bool {
        return self.year == otherDate.year
            && self.month == otherDate.month
    }
    
    /// 比较日期是否在同年
    /// - Parameter otherDate: 日期
    func isSameYear(otherDate: Date) -> Bool {
        return self.year == otherDate.year
    }
}

public extension Date {
    /// 转化为日期字符串
    ///
    /// - Parameter dateFormat: 格式化样式,默认“yyyy-MM-dd HH:mm:ss”
    /// - Returns: 日期字符串
    func toString(dateFormat:String = sDateFormat_Default) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = dateFormat
        return formatter.string(from: self)
    }
}
