//
//  FlutterTestViewController.swift
//  ZhouApp
//
//  Created by ZhouMin on 2021/2/4.
//

import UIKit
import Flutter

class FlutterTestViewController: UIViewController {

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
        let engine = (UIApplication.shared.delegate as! AppDelegate).engine
        let controller = FlutterViewController.init(engine: engine, nibName: nil, bundle: nil);
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
    }
}
