//
//  UIApplication+Extension.swift
//  Alamofire
//
//  Created by zhoumin on 2019/8/21.
//

import Foundation



public extension UIApplication {
    
    /// 获取当前APP rootViewController
    ///
    /// - Returns: 返回rootViewController
    class func rootViewController() -> UIViewController?  {
        return UIApplication.shared.keyWindow?.rootViewController
    }
    
    /// Retrieve the view controller currently on-screen
    static var currentController: UIViewController? {
        if let controller = UIApplication.shared.keyWindow?.rootViewController {
            return findCurrent(controller)
        }
        return nil
    }
    
    private static func findCurrent(_ controller: UIViewController) -> UIViewController {
        if let controller = controller.presentedViewController {
            return findCurrent(controller)
        }
        else if let controller = controller as? UINavigationController, let topViewController = controller.topViewController, controller.viewControllers.count > 0 {
            return findCurrent(topViewController)
        }
        else if let controller = controller as? UITabBarController, let selectedViewController = controller.selectedViewController, (controller.viewControllers?.count ?? 0) > 0 {
            return findCurrent(selectedViewController)
        }
        else {
            return controller
        }
    }
    
    
    class func open(url: Foundation.URL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:]) { (result) in
                
            }
        } else {
            logging("Can not execute the given action.")
        }
    }
    
    class func open(urlPath: String) {
        if let url = URL(string: urlPath) {
            UIApplication.open(url: url)
        }
    }
    
    class func makePhone(to phoneNumber: String) {
        UIApplication.open(urlPath: "telprompt:\(phoneNumber)")
    }
    
    class func sendMessage(to phoneNumber: String) {
        UIApplication.open(urlPath: "sms:\(phoneNumber)")
    }
    
    class func email(to email: String) {
        UIApplication.open(urlPath: "mailto:\(email)")
    }
    
}
