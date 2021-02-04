//
//  UITableViewCell+Extection.swift
//  CrovAssistant
//
//  Created by zhoumin on 2019/9/10.
//  Copyright © 2019 zhoumin. All rights reserved.
//

import UIKit

public extension UITableViewCell {
    
    /// 使用背景色初始化cell
    ///
    /// - Parameter color: 背景色
    convenience init(color: UIColor) {
        self.init(style: .default, reuseIdentifier: nil)
        self.backgroundColor = color
    }
    
    /// 使用背景色初始化cell
    ///
    /// - Parameter color: 背景色
    convenience init(hexColor: String) {
        self.init(style: .default, reuseIdentifier: nil)
        self.backgroundColor = UIColor(hex: hexColor)
    }
}
