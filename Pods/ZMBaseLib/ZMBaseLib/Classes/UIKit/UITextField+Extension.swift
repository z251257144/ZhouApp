//
//  UITextField+Extension.swift
//  CrovAssistant
//
//  Created by zhoumin on 2019/9/18.
//  Copyright © 2019 zhoumin. All rights reserved.
//

import UIKit

private var textFieldTextLength = "textFieldTextLength"

public extension UITextField {
    /// 最大输入长度
    @IBInspectable var maxLength:Int {
        //通过运行时添加实例属性
        set {
            objc_setAssociatedObject(self, &textFieldTextLength, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
            self.addTarget(self, action: #selector(textFieldEditingChange(textField:)), for:.editingChanged)
        }
        get {
            return (objc_getAssociatedObject(self, &textFieldTextLength) as? Int) ?? 0
        }
    }
    
    /**
     编辑中
     - parameter textField: 当前编辑的textField
     */
    @objc func textFieldEditingChange(textField:UITextField ) {
        guard let _ = textField.text else { return }
        
        if let positionRange = textField.markedTextRange {
            if let _ = textField.position(from: positionRange.start, offset: 0){
                //正在使用拼音，不进行校验
                return
            }
        }
        
        //不在使用拼音，进行校验
        self.checkLength(textField: textField)
    }
    
    
    /**
     长度检测
     - parameter textField: 当前检测的textField
     */
    func checkLength(textField:UITextField) {
        guard let text = textField.text else { return }
        if self.maxLength <= 0 || text.count <= self.maxLength {
            //长度正常，不处理
            return
        }
            
        //超出长度，截取最大限制字符数.
        textField.text = text.substring(to: self.maxLength-1)
    }
}
