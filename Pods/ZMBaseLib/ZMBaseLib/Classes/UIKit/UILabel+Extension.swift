//
//  UILabel+Extension.swift
//  MICSupplier
//
//  Created by zhoumin on 2018/3/2.
//  Copyright © 2018年 songshanping. All rights reserved.
//

import Foundation

extension UILabel {
    /// 计算Label文本全部显示的高度
    /// 备注：需要设置preferredMaxLayoutWidth属性
    /// - Parameter label: Label
    /// - Returns: 高度
    func heightToShowAllText() -> CGFloat {
        let text = self.text
        if text == nil || text!.isEmpty {
            return 0
        }
        
        return text!.layoutHeight(width: self.preferredMaxLayoutWidth, font: self.font)
    }
    
    //给UILabel设置行间距
    func setText(text : String?, lineSpacing : Float) {
        if text == nil || text!.isEmpty {
            self.attributedText = NSAttributedString()
            self.text = nil
            return;
        }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = CGFloat(lineSpacing)
        paragraphStyle.lineBreakMode = NSLineBreakMode.byTruncatingTail //NSLineBreakByTruncatingTail
        
        var attributes = Dictionary<NSAttributedString.Key, Any>()
        attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        
        let attributeStr = NSAttributedString(string: text!, attributes: attributes)
        self.attributedText = attributeStr
    }
}


