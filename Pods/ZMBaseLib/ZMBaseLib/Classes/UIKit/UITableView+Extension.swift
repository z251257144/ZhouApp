//
//  UITableView+Extension.swift
//  CrovAssistant
//
//  Created by zhoumin on 2019/9/10.
//  Copyright © 2019 zhoumin. All rights reserved.
//

import UIKit

public extension UITableView {
    /**
     Use it as a trick to remove the separator lines of blank cells at the bottom of tableView.
     */
    func removeBottomSeparatorLine() {
        tableFooterView = UIView(frame: CGRect.zero)
    }
    
    func registerNibname(_ nameAndIdentifier: String, bundle: Bundle? = nil) {
        self.register(UINib(nibName: nameAndIdentifier, bundle: bundle), forCellReuseIdentifier: nameAndIdentifier)
    }
    
}

