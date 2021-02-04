//
//  HomeMenuModel.swift
//  ZhouApp
//
//  Created by ZhouMin on 2021/2/4.
//

import Foundation
import SwiftyJSON

class HomeMenuModel: NSObject {
    var title = ""
    var className = ""
    
    convenience init(fromJson json: JSON){
        self.init()
        title = json["title"].stringValue
        className = json["Class"].stringValue
    }
}
