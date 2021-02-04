//
//  SwiftConstants.swift
//  MICSupplier
//
//  Created by zhoumin on 2018/2/9.
//  Copyright © 2018年 songshanping. All rights reserved.
//

import UIKit

// MARK: - 设备信息
/// 全屏宽度
public let sMainScreenWidth = UIScreen.main.bounds.width
/// 全屏高度
public let sMainScreenHeight = UIScreen.main.bounds.height



// MARK: - Async Task
public func sMainThreadRun(_ work: @escaping () -> ()) {
    if Thread.isMainThread {
        work()
    } else {
        DispatchQueue.main.async(execute: work)
    }
}

public func sBackThreadRun(execute work: @escaping () -> ()) {
    if !Thread.isMainThread {
        work()
    } else {
        DispatchQueue.global().async(execute: work)
    }
}






