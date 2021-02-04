//
//  HomeViewModel.swift
//  ZhouApp
//
//  Created by ZhouMin on 2021/2/4.
//

import ZMBaseLib
import SwiftyJSON

class HomeViewModel: BaseViewModel {
    
    let menuArray : [HomeMenuModel]
    
    override init() {
        print("初始化 HomeViewModel")
        let path = Bundle.main.path(forResource: "Functions", ofType: "plist") ?? ""
        let data : NSArray = NSArray(contentsOfFile:path) ?? []
        let json = JSON(data)
        self.menuArray = json.arrayValue.map { (item) -> HomeMenuModel in
            return HomeMenuModel(fromJson: item)
        }
        print(menuArray)
    }
    
}
