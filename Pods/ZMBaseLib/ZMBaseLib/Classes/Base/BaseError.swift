//
//  BaseError.swift
//  Alamofire
//
//  Created by zhoumin on 2019/8/19.
//

import Foundation

public enum BaseErrorCode : Int, CustomStringConvertible {
    case JSONParse = 3840
    case EmptyData = 3333   //数据为空，或数据结构不规范
    
    
    public var description: String {
        if self == .JSONParse {
//            return "Server Data Error"
        }
        return BaseErrorType.dataError.localizedDescription
    }
}


public enum BaseErrorType: Error {
    case connectInternetFailed      //无网络
    case timeout                    //连接超时
    case connectionError            //连接错误，e.g: 404, 500,
    case dataError                  //数据异常，e.g: 数据为空，数据解析识别
    case others                     //其它错误，e.g: 接口返回错误
    
    /// 实现Error协议的localizedDescription只读实例属性
    var localizedDescription: String {
        if self == .connectInternetFailed {
            return "No network connection. Please check your network settings and try again."
        }
        else if self == .timeout {
            return "Sorry! Request timed out. Please try again."
        }
        else if self == .connectionError {
             return "Sorry, service request was interrupted, please retry."
        }
        else if self == .dataError {
            return "Internal server parse error. Please try again later."
        }
        return "Other error"
    }
}

public struct BaseError: Error {
    public var type: BaseErrorType
    public var code: Int
    public var reason: String?
    public var url: String?
    
    public init(type: BaseErrorType, code: Int, reason: String? = nil) {
        self.type = type
        self.code = code
        self.reason = reason
    }
    
    
    public init(error: Error) {
        self.code = error._code
        
        if error._code == NSURLErrorNotConnectedToInternet {
            // 无网络
            self.type = BaseErrorType.connectInternetFailed
            self.reason = BaseErrorType.connectInternetFailed.localizedDescription
        }
        else if error._code == NSURLErrorTimedOut {
            // 连接超时
            self.type = BaseErrorType.timeout
            self.reason = BaseErrorType.timeout.localizedDescription
        }
        else {
            self.type = BaseErrorType.connectionError
            self.reason = error.localizedDescription
        }
    }
    
    public static func emptyData() -> BaseError {
        return BaseError(type: .dataError, code: BaseErrorCode.EmptyData.rawValue, reason: BaseErrorType.dataError.localizedDescription)
    }
}

extension BaseError: CustomStringConvertible {
    
    private var location: String? {
        return "\(type.localizedDescription).\(code):\(reason ?? "nil")"
    }
    
    public var description: String {
        let info: [(String, Any?)] = [
            ("- reason", reason),
            ("- code", code),
            ("- type", type),
        ]
        let infoString = info.map { "\($0.0): \($0.1 ?? "nil")" }.joined(separator: "\n")
        return "\n\(infoString)"
    }
    
}


