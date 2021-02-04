//
//  UIView+Extension.swift
//  Pods-ZMToolsLib_Example
//
//  Created by zhoumin on 2019/8/15.
//

import UIKit

public extension UIView {
    
    /// 从Xib文件初始化UIView
    ///
    /// - Parameter name: xib名称
    /// - Returns: uiview对象
    class func viewFromNibName(_ name: String) -> UIView? {
        let views = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
        return views?.first as? UIView
    }
}


// MARK: - UIView frame相关属性seter、geter
public extension UIView {
    
    /**
     seter，geter方法
     view frame中size、 size.width、 frame.height
     */
    var cg_size: CGSize {
        set { frame.size = newValue }
        get { return frame.size }
    }
    
    var cg_width: CGFloat {
        set { frame.size.width = newValue }
        get { return frame.width }
    }
    
    var cg_height: CGFloat {
        set { frame.size.height = newValue }
        get { return frame.height }
    }
    
    /**
     seter，geter方法
     view frame中origin、 origin.y、 origin.x
     */
    var cg_origin: CGPoint {
        set { frame.origin = newValue }
        get { return frame.origin }
    }
    
    var originX: CGFloat {
        set { frame.origin.x = newValue }
        get { return frame.origin.x }
    }
    
    var originY: CGFloat {
        set { frame.origin.y = newValue }
        get { return frame.origin.y }
    }
    
    /**
     geter方法
     view frame中origin、 origin.y、 origin.x
     */
    var cg_right : CGFloat {
        get { return frame.origin.x + frame.size.width }
    }
    
    var cg_bottom : CGFloat {
        get { return frame.origin.y + frame.size.height }
    }
}


public extension UIView {
    
    /**
     边框宽度
     */
    @IBInspectable var borderWidth: CGFloat {
        set { layer.borderWidth = newValue }
        get { return layer.borderWidth }
    }
    
    
    /**
     边框颜色
     */
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
    /**
     圆角
     */
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.masksToBounds = true
            layer.cornerRadius = newValue
        }
        get { return layer.cornerRadius }
    }
    
    
    /// 设置边框颜色、大小
    ///
    /// - Parameters:
    ///   - color: 颜色
    ///   - width: 大小
    func setBorder(color:UIColor, width: CGFloat) {
        self.layer.masksToBounds = true
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
    /// 设置随机边框
    func setRandomBorder() {
        self.setBorder(color: BorderColors.random(), width: 1)
    }
}

struct BorderColors{
    static let randomColorArray : [UIColor] = {
        var borderColors = [UIColor]()
        borderColors.append(UIColor.red)
        borderColors.append(UIColor.green)
        borderColors.append(UIColor.blue)
        borderColors.append(UIColor.black)
        borderColors.append(UIColor.orange)
        borderColors.append(UIColor.purple)
        
        return borderColors
    }()
    
    /// 获取边框随机色
    ///
    /// - Returns: 颜色
    static func random() -> UIColor {
        let i = Int(arc4random_uniform(UInt32(randomColorArray.count)))
        return randomColorArray[i]
    }
}
