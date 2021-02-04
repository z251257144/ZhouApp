//
//  UIScrollView+Extension.swift
//  Alamofire
//
//  Created by zhoumin on 2019/8/21.
//

import Foundation

extension UIScrollView {
    
    /**
     滚动至顶部
     */
    func scrollToTop(animated: Bool = true) {
        let topOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(topOffset, animated: animated)
    }
    
    
    /**
     滚动至底部
     */
    func scrollToBottom(animated: Bool = true) {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        if(bottomOffset.y > 0) {
            setContentOffset(bottomOffset, animated: animated)
        }
    }
    
    
}
