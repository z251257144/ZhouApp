//
//  WebClient.swift
//  Alamofire
//
//  Created by zhoumin on 2019/8/14.
//

import UIKit
import Alamofire

/**
 请求成功回调
 */
public typealias ResponceSuccessBlock = (Bool) -> ()
public typealias ResponceBlock = (Any?, Error?) -> ()

public class WebClient: NSObject {
    
    //公共的私有方法
    func request(_ request: DataRequest, _ complition:@escaping ResponceBlock) {
        request.responseData { response in
            switch (response.result) {
                case .success:
                    #if DEBUG
                        let dataString = String.init(data: response.data!, encoding: .utf8) ?? ""
                        print("================== response.dataString ==================")
                        print(dataString)
                    #endif
                    self.response(data: response.data, complition: complition)
                    break
                case .failure(let error):
                    //网络接口错误
                    logging(error)
                    let baseError = BaseError(error: error)
                    complition(nil, baseError)
                    break
            }
        }
    }
    
    //公共的私有方法
    func request(_ urlString: String,
                 params: Parameters? = nil,
                 method: HTTPMethod,
                 headers: HTTPHeaders? = nil,
                 _ complition:@escaping ResponceBlock) {
        logging(urlString)
        if params != nil {
            logging(params!)
        }
        
        let manager = Alamofire.Session.default
        manager.session.configuration.timeoutIntervalForRequest = 30
        
        var encoding: ParameterEncoding =  URLEncoding.default
        if method == HTTPMethod.post {
            encoding = JSONEncoding.default
        }
         
        let request = manager.request(urlString, method: method, parameters:params, encoding: encoding, headers: headers)
        self.request(request, complition)
    }
    
    /// GET请求
    func getRequest(_ urlString: String,
                    params: Parameters? = nil,
                    headers: HTTPHeaders? = nil,
                    _ complition:@escaping ResponceBlock) {
        self.request(urlString, params: params, method: .get, headers: headers) { (value, error) in
            complition(value, error)
        }
    }
    
    /// Post请求
    func postRequest(_ urlString: String,
                     params: Parameters? = nil,
                     headers: HTTPHeaders? = nil,
                     _ complition:@escaping ResponceBlock) {
        self.request(urlString, params: params, method: .post, headers: headers) { (value, error) in
            complition(value, error)
        }
    }
    
    /// 网络请求回调
    ///
    /// - Parameters:
    ///   - data: 接口返回数据
    ///   - complition: 回调
    func response(data:Any?, complition:@escaping ResponceBlock) {
        if data == nil {
            //空数据错误
            let err = BaseError(type: .dataError, code: BaseErrorCode.EmptyData.rawValue, reason: BaseErrorCode.EmptyData.description)
            complition(nil, err)
        }
        else {
            complition(data, nil)
        }
    }
}
