//
//  UIControl+Extension.swift
//  Alamofire
//
//  Created by zhoumin on 2019/8/21.
//

import Foundation

extension UIControl {
    private struct UIControlAssociatedKeys {
        static var action = "UIControlAssociatedKeysAction"
    }
    
    typealias UIControlAction = () -> Void
    
    private var action: UIControlAction? {
        set { objc_setAssociatedObject(self, &UIControlAssociatedKeys.action, newValue, .OBJC_ASSOCIATION_RETAIN) }
        get { return objc_getAssociatedObject(self, &UIControlAssociatedKeys.action) as? UIControlAction }
    }
    
    
    /**
     Adds the given closure as the control's target action
     
     - parameter controlEvents: The UIControlEvents upon which to execute this action.
     - parameter action:        The action closure to execute.
     */
    public func addTarget(for controlEvents: UIControl.Event, actionClosure: @escaping () -> Void) {
        self.action = actionClosure
        addTarget(self, action: #selector(handleAction), for: controlEvents)
    }
    
    @objc func handleAction() {
        self.action?()
    }
}
