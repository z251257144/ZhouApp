//
//  MethodChanel.swift
//  ZhouApp
//
//  Created by ZhouMin on 2021/2/5.
//

import Foundation
import Flutter

class MethodChannel {
    var count =  0
    var channel:FlutterMethodChannel
    
    var timer : Timer?
    
    init(messenger: FlutterBinaryMessenger) {
        channel = FlutterMethodChannel(name: "com.zhou.MethodChannel", binaryMessenger: messenger)
        channel.setMethodCallHandler { (call:FlutterMethodCall, result:@escaping FlutterResult) in
            print(call.method)
            print(call.arguments ?? "")
            if (call.method == "flutterSendData") {
                result("Native收到Flutter发送的消息了，'\(call.arguments)'")
            }
        }
        startTimer()
    }
        
    func startTimer() {
        self.timer = Timer.scheduledTimer(timeInterval:1, target: self, selector:#selector(self.tickDown),userInfo:nil,repeats: true)
    }
    @objc func tickDown(){
        count += 1
        let args = ["count":count]
//        arguments数据格式需和flutter接收处理的数据格式一致。
        self.channel.invokeMethod("nativeSendData", arguments:args) { (result) in
            print(result ?? "")
        }
//        self.channel.invokeMethod("nativeSendData", arguments:"dsfsd \(self.count)") { (result) in
//            print(result ?? "")
//        }
        
//        print(self.channel)
        
        
//        if self.count > 20 {
//            self.timer?.invalidate()
//            self.timer = nil
//            self.count = 0;
//        }
    }
}
