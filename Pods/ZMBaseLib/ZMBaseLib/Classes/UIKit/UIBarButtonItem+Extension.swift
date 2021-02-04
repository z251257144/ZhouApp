//
//  UIBarButtonItem+Extension.swift
//  ZMBaseLib
//
//  Created by zhoumin on 2019/9/5.
//

import Foundation

extension UIBarButtonItem {
    
    public convenience init(image: UIImage?, highlightedImage: UIImage? = nil, target: Any?, action: Selector?) {
        let button = UIButton(type: .custom)
        button.frame = CGRect(origin: CGPoint.zero, size: image?.size ?? CGSize.zero)
        button.setImage(image, for: .normal)
        button.setImage(highlightedImage, for: .highlighted)
        if action != nil {
            button.addTarget(target, action: action!, for: .touchUpInside)
        }
        self.init(customView: button)
    }
    
    public convenience init(title: String, titleColor: UIColor, highlightedColor: UIColor? = nil, disabledColor: UIColor? = nil, target: Any?, action: Selector?) {
        self.init(title: title, style: .plain, target: target, action: action)
        self.setTitleTextAttributes([.foregroundColor:titleColor], for: .normal)
        
        if highlightedColor != nil {
            self.setTitleTextAttributes([.foregroundColor:highlightedColor!], for: .highlighted)
        }
        
        if disabledColor != nil {
            self.setTitleTextAttributes([.foregroundColor:disabledColor!], for: .disabled)
        }
    }
}


