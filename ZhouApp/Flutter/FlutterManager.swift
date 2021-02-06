//
//  FlutterManager.swift
//  ZhouApp
//
//  Created by ZhouMin on 2021/2/4.
//

import Foundation
import Flutter
import FlutterPluginRegistrant
//import GeneratedPluginRegistrant

class FlutterManager: NSObject {
    
    static let `default` = FlutterManager()
    
    ///初始化Flutter引擎
    lazy var engine:FlutterEngine = FlutterEngine.init(name: "zhou");
    

    
    private override init() {}
    
    /// 初始化Flutter相关
    func initFlutter() {
        self.engine.run()
        GeneratedPluginRegistrant.register(with: self.engine)
    }
    
    
    
}
