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
        channel = FlutterMethodChannel(name: "com.flutter.guide.MethodChannel", binaryMessenger: messenger)
        channel.setMethodCallHandler { (call:FlutterMethodCall, result:@escaping FlutterResult) in
            print(call.method)
            if (call.method == "flutterSendData") {
                print(call.arguments ?? "")
//                if let dict = call.arguments as? Dictionary<String, Any> {
//                    let name:String = dict["name"] as? String ?? ""
//                    let age:Int = dict["age"] as? Int ?? -1
//                    result(["name":"hello,\(name)","age":age])
//                }
                result("Native收到Flutter发送的消息了，'\(call.arguments)'")
            }
        }
//        startTimer()
    }
        
    func startTimer() {
        self.timer = Timer.scheduledTimer(timeInterval:1, target: self, selector:#selector(self.tickDown),userInfo:nil,repeats: true)
    }
    @objc func tickDown(){
        count += 1
        var args = ["count":count]
        channel.invokeMethod("timer", arguments:args)
    }
}
