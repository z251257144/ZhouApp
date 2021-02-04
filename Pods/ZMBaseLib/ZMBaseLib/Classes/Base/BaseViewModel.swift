//
//  ViewModel.swift
//  MICSupplier
//
//  Created by zhoumin on 2018/2/9.
//  Copyright © 2018年 songshanping. All rights reserved.
//

import UIKit
import Alamofire


open class BaseViewModel: NSObject {
    var webClient = WebClient();
    public var error : BaseError?
    
    public var pageIndex : Int = 0
    public var hasMoreData : Bool = true
    
    
    /// 获取公共参数
    ///
    /// - Returns: 参数数组
    open func getCommonParams() -> Dictionary<String, Any> {
        var param = Dictionary<String, Any>()
        
        if !BaseConfig.commonParams.isEmpty {
            param.merge(dict: BaseConfig.commonParams)
        }
        
        return param
    }
    
    /// POST网络请求
    ///
    /// - Parameters:
    ///   - method: 请求接口名称
    ///   - params: 参数
    ///   - complition: 回调
    open func fetchPostServerData(method: String,
                                  params:Dictionary<String, Any>?,
                                  headers: HTTPHeaders? = nil,
                                  complition:@escaping ResponceBlock) {
        assert(BaseConfig.baseAppServiceUrl.count > 0, "请设置BaseConfig.basekAppServiceUrl链接")
        self.fetchPostServerData(BaseConfig.baseAppServiceUrl+"/"+method, params: params, headers: headers, complition: complition)
    }
    
    /// POST网络请求
    ///
    /// - Parameters:
    ///   - urlString: 请求地址
    ///   - params: 参数
    ///   - complition: 回调
    open func fetchPostServerData(_ urlString: String,
                                  params:Dictionary<String, Any>?,
                                  headers: HTTPHeaders? = nil,
                                  complition:@escaping ResponceBlock) {
        webClient.postRequest(urlString, params: params, headers: headers) { (value, error) in
            self.responseHandle(data: value, error: error as? BaseError, complition: complition)
        }
    }
    
    /// Get网络请求
    ///
    /// - Parameters:
    ///   - method: 请求接口名称
    ///   - params: 参数
    ///   - complition: 回调
    open func fetchGetServerData(method: String, params:Dictionary<String, Any>?, headers: HTTPHeaders? = nil, complition:@escaping ResponceBlock) {
        assert(BaseConfig.baseAppServiceUrl.count > 0, "请设置BaseConfig.basekAppServiceUrl链接")
        self.fetchGetServerData(BaseConfig.baseAppServiceUrl+"/"+method, params: params, headers: headers, complition: complition)
    }
    
    /// Get网络请求
    ///
    /// - Parameters:
    ///   - urlString: 请求地址
    ///   - params: 参数
    ///   - complition: 回调
    open func fetchGetServerData(_ urlString: String, params:Dictionary<String, Any>?, headers: HTTPHeaders? = nil, complition:@escaping ResponceBlock) {
        webClient.getRequest(urlString, params: params, headers: headers) { (value, error) in
            self.responseHandle(data: value, error: error as? BaseError, complition: complition)
        }
    }
    
    /// 上传文件
    ///
    /// - Parameters:
    ///   - method: 地址方法
    ///   - param: 参数
    ///   - complition: 回调
    open func uploadFileToServer(method:String, param:Dictionary<String, Any>, complition:@escaping ResponceBlock) {

    }
    
    /// 网络请求回调
    ///
    /// - Parameters:
    ///   - data: 接口返回数据
    ///   - error: 错误
    ///   - complition: 回调
    open func responseHandle(data:Any?, error: BaseError?, complition:@escaping ResponceBlock) {
        if error != nil {
            self.error = error
            complition(nil, error)
            return
        }
        
        var err: BaseError?
        var jsonData: Any?
        
        do {
            jsonData = try JSONSerialization.jsonObject(with: data! as! Data, options: .mutableContainers)
//            logging("jsonData = \(jsonData ?? "json解析为空")")
            
            err = self.verifyJsonData(jsonData ?? "")
            if err == nil {
                jsonData = (jsonData as! Dictionary<String, Any>)["data"]
            }
        }
        catch {
            //json数据解析错误
            err = BaseError(type: .dataError, code: BaseErrorCode.JSONParse.rawValue, reason: BaseErrorCode.JSONParse.description)
        }
        
        self.error = err
        complition(jsonData, err)
    }
    
    /// 校验返回数据格式和数据结果
    ///
    /// - Parameter json: json数据
    /// - Returns: 数据有问题返回错误；否则返回结果
    open func verifyJsonData(_ json: Any) -> BaseError? {
        
        if json is Dictionary<String, Any>{
            let jsonData = json as! Dictionary<String, Any>
            
            var code: Int = BaseErrorCode.EmptyData.rawValue
            
            let jsonCode = jsonData["code"]
            if jsonCode is Int {
                code = jsonCode as! Int
            }
            else if jsonCode is String {
                code = Int(jsonCode as! String) ?? BaseErrorCode.EmptyData.rawValue
            }
            
            if code == 0 {
                return nil
            }
            
            var reason = jsonData["message"] as? String
            if code == BaseErrorCode.EmptyData.rawValue {
                reason = BaseErrorCode.EmptyData.description
            }
            return BaseError(type: .others, code: code, reason: reason)
        }
        
        //空数据错误
        return BaseError(type: .dataError, code: BaseErrorCode.EmptyData.rawValue, reason: BaseErrorCode.EmptyData.description)
    }
}
