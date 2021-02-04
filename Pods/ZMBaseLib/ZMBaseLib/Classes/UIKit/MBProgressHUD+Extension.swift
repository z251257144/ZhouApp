//
//  BaseProgressHUD.swift
//  Alamofire
//
//  Created by zhoumin on 2019/8/19.
//

import Foundation
import MBProgressHUD

public extension MBProgressHUD {
    
    /**
     显示纯文本信息

     @param message 消息文本
     @param time HUD展示时长
     @param view 展示的View
     */
    static func showMessage(_ message: String?, hideAfterDelay: TimeInterval = 1.5, view: UIView? = nil) {
        DispatchQueue.main.async {
            var toView = view
            if toView == nil {
                toView = UIApplication.shared.keyWindow
            }
            
            assert(toView != nil, "View must not be nil.")
            
            if message == nil {
                return
            }
            
            // 快速显示一个提示信息
            let hud = MBProgressHUD.showAdded(to: toView!, animated: false)
            hud.mode = .text
            
            hud.detailsLabel.text = message
            hud.bezelView.backgroundColor = UIColor.black
            hud.detailsLabel.textColor = UIColor.white
            hud.detailsLabel.font = UIFont.boldSystemFont(ofSize: 15)
            
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true, afterDelay: hideAfterDelay)
        }
    }
    
    /**
     显示转圈圈加载状态
     
     @param message 消息文本
     @param view 展示的View
     @return MBProgressHUD对象，可以通过它调用MBProgressHUD中的方法
     */
    @discardableResult
    static func showActivityLoading(_ message: String? = nil, view: UIView? = nil) -> MBProgressHUD {
        var toView = view
        if toView == nil {
            toView = UIApplication.shared.keyWindow
        }
        
        assert(toView != nil, "View must not be nil.")
        
        
        let hud = MBProgressHUD.showAdded(to: toView!, animated: false)
        hud.mode = .indeterminate
        hud.removeFromSuperViewOnHide = true
        
        hud.bezelView.backgroundColor = UIColor.black
        hud.contentColor = UIColor.white
        hud.label.font = UIFont.boldSystemFont(ofSize: 15)
        
        if (message != nil) {
            hud.label.text = message;
        }
        
        return hud
    }
    
    /**
     从view上移除HUD
     
     @param view 展示HUD的View
     */
    static func hideHUD(_ view: UIView? = nil, animated: Bool = false) {
        var toView = view
        if toView == nil {
            toView = UIApplication.shared.keyWindow
        }
        
        if toView == nil {
            return
        }
        
        MBProgressHUD.hide(for: toView!, animated: animated)
        
    }
}


public extension UIView {
    
    func showLoadingHUD(_ message: String? = nil) {
        DispatchQueue.main.async {
            MBProgressHUD.showActivityLoading(message, view: self)
        }
    }
    
    /**
     从view上移除HUD
     */
    func hideHUD(animated: Bool = false) {
        DispatchQueue.main.async {
            MBProgressHUD.hideHUD(self, animated: animated)
        }
    }
}
