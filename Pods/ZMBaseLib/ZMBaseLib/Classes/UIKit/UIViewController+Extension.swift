//
//  UIViewController+Extension.swift
//  ZMBaseLib
//
//  Created by zhoumin on 2019/9/5.
//

import Foundation

extension UIViewController {
    
    /**
     设置左上方按钮的image, highlightedImage、target和selector
     */
    @discardableResult public func setLeftItem(image: UIImage?, highlightedImage: UIImage? = nil, target: Any?, action: Selector?) -> UIBarButtonItem {
        let item = UIBarButtonItem(image: image, highlightedImage: highlightedImage, target: target, action: action)
        self.setLeftItem(item)
        return item
    }
    
    /**
     设置左上方按钮的title, titleColor、 highlightedColor、 disabledColor、target和selector
     */
    @discardableResult public func setLeftItem(title: String, titleColor: UIColor, highlightedColor: UIColor? = nil, disabledColor: UIColor? = nil, target: Any?, action: Selector?) -> UIBarButtonItem {
        let item = UIBarButtonItem(title: title, titleColor: titleColor, highlightedColor: highlightedColor, disabledColor: disabledColor, target: target, action: action)
        self.setLeftItem(item)
        return item
    }
    
    /**
     设置右上方按钮的image, highlightedImage、target和selector
     */
    @discardableResult public func setRightItem(image: UIImage?, highlightedImage: UIImage? = nil, target: Any?, action: Selector?) -> UIBarButtonItem {
        let item = UIBarButtonItem(image: image, highlightedImage: highlightedImage, target: target, action: action)
        self.setRightItem(item)
        return item
    }
    
    /**
     设置右上方按钮的title, titleColor、 highlightedColor、 disabledColor、target和selector
     */
    @discardableResult public func setRightItem(title: String, titleColor: UIColor, highlightedColor: UIColor? = nil, disabledColor: UIColor? = nil, target: Any?, action: Selector?) -> UIBarButtonItem {
        let item = UIBarButtonItem(title: title, titleColor: titleColor, highlightedColor: highlightedColor, disabledColor: disabledColor, target: target, action: action)
        self.setRightItem(item)
        return item
    }
    
    
    /// 给系统导航栏添加左边View(删除左边20间隔)
    ///
    /// - Parameter leftView: leftView
    func setLeftItem(_ leftItem: UIBarButtonItem) {
        if #available(iOS 11, *) {
            self.navigationItem.leftBarButtonItems = [leftItem]
        } else {
            // 用于消除左边空隙，要不然按钮顶不到最左边
            let leftSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            leftSpace.width = -20
            self.navigationItem.leftBarButtonItems = [leftSpace, leftItem]
        }
    }
    
    /// 给系统导航栏添加右边View(删除右边20间隔)
    ///
    /// - Parameter rightView: rightView
    func setRightItem(_ rightItem: UIBarButtonItem) {
        if #available(iOS 11, *) {
            self.navigationItem.rightBarButtonItems = [rightItem]
        } else {
            // 用于消除右边空隙，要不然按钮顶不到最右边
            let rightSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            rightSpace.width = -20
            self.navigationItem.rightBarButtonItems = [rightSpace, rightItem]
        }
    }
}
