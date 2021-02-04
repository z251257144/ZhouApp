//
//  FlutterTestViewController.swift
//  ZhouApp
//
//  Created by ZhouMin on 2021/2/4.
//

import UIKit
import Flutter

class FlutterTestViewController: UIViewController {
    
    //初始化的方法
    var channel:FlutterEventChannel?
    var eventSink:FlutterEventSink?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func showFlutterViewController(_ sender: Any) {
        let engine = FlutterManager.default.engine
        let flutterController = FlutterViewController.init(engine: engine, nibName: nil, bundle: nil);
        flutterController.modalPresentationStyle = .fullScreen
        
        self.channel = FlutterEventChannel(name: "com.pages.flutter", binaryMessenger: flutterController as! FlutterBinaryMessenger)
                
        self.channel?.setStreamHandler(self)
        
        self.navigationController?.pushViewController(flutterController, animated: true)
    }
}

extension FlutterTestViewController: FlutterStreamHandler
{
    //ios 主动给flutter 发送消息回调方法
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        return nil
    }
    
    
}
