//
//  EventChannel.swift
//  ZhouApp
//
//  Created by ZhouMin on 2021/2/7.
//

import Foundation
import Flutter

class EventChannel: NSObject {
    var eventChannel: FlutterEventChannel?
    
    convenience init(messenger: FlutterBinaryMessenger) {
        self.init()
        
        eventChannel = FlutterEventChannel(name: "", binaryMessenger: messenger)
        eventChannel?.setStreamHandler(self)
        
//        super.init()
    }
    
    
    
}

extension EventChannel: FlutterStreamHandler
{
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        print(arguments)
        return nil;
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        print(arguments)
        return nil;
    }
    
    
}
