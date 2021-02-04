//
//  UINavigationBar+Extension.swift
//  CrovAssistant
//
//  Created by zhoumin on 2019/9/25.
//  Copyright © 2019 zhoumin. All rights reserved.
//

import UIKit

public extension UINavigationBar {
    
    /// 设置导航栏背景颜色
    ///
    /// - Parameter color: 颜色
    func setNavigationBar(color: UIColor) {
        //将背景栏设置为不透明
        self.isTranslucent = false
        
        let image = UIImage(color: color, size: CGSize(width: 1, height: 1))
        self.setBackgroundImage(image, for: .default)
    }
    
    /// 设置导航栏阴影
    ///
    /// - Parameter color: 颜色
    func setNavigationBarShadowLine(color: UIColor) {
        let image = UIImage(color: color, size: CGSize(width: sMainScreenWidth, height: 0.5))
        self.shadowImage = image
    }
}
