//
//  String+Validate.swift
//  Pods-ZMToolsLib_Example
//
//  Created by zhoumin on 2019/8/15.
//

import Foundation

public enum StringValidate : String {
    // 登录名
    case username = "^[A-Za-z0-9]{6,20}+$"
    // 密码
    case password = "^[a-zA-Z0-9]{6,12}+$"
    // 邮箱
    case email = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
    // 手机号码验证
    case phoneNum  = "^1[3-9]{10}$"
    // 网址
    case URL = "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$"
    // ip
    case IP  = "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
    // 身份证号
    case idCard =  "(^[1-9]\\d{5}(18|19|([23]\\d))\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$)|(^[1-9]\\d{5}\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{2}$)"
    // 只包含数字
    case numbers = "^[0-9]+$"
    // 只包含字母和数字
    case lettersAndNumbers = "^[a-zA-Z0-9]{1,30}+$"
}

public extension String {
    
    func validate(_ predicate: String) -> Bool {
        let predicate =  NSPredicate(format: "SELF MATCHES %@" ,predicate)
        return predicate.evaluate(with: self)
    }
    
    func validateEmail() -> Bool {
        return self.validate(StringValidate.email.rawValue)
    }
    
    func validatePhoneNumber() -> Bool {
        return self.validate(StringValidate.phoneNum.rawValue)
    }
}
