//
//  HomeViewController.swift
//  ZhouApp
//
//  Created by ZhouMin on 2021/2/3.
//

import UIKit

class HomeViewController: UIViewController {
    
    let viewModel = HomeViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    /// 类文件字符串转换为ViewController
    ///
    /// - Parameter childControllerName: VC的字符串
    /// - Returns: ViewController
    func VCSTRING_TO_VIEWCONTROLLER(_ childControllerName: String) -> UIViewController?{

        // 1.获取命名空间
        // 通过字典的键来取值,如果键名不存在,那么取出来的值有可能就为没值.所以通过字典取出的值的类型为AnyObject?
        guard let clsName = Bundle.main.infoDictionary!["CFBundleExecutable"] else {
            print("命名空间不存在")
            return nil
        }
        // 2.通过命名空间和类名转换成类
        let cls : AnyClass? = NSClassFromString((clsName as! String) + "." + childControllerName)

        // swift 中通过Class创建一个对象,必须告诉系统Class的类型
        guard let clsType = cls as? UIViewController.Type else {
            print("无法转换成UIViewController")
            return nil
        }
        // 3.通过Class创建对象
        let childController = clsType.init()

        return childController
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.menuArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as? MenuTableViewCell else {
            return UITableViewCell()
        }

        let model = self.viewModel.menuArray[indexPath.row]
        cell.show(model)
//        if cell is CrovBaseCellShowDelegate {
//            (cell as! CrovBaseCellShowDelegate).show(model: model)
//        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.viewModel.menuArray[indexPath.row]
        guard let controller = self.VCSTRING_TO_VIEWCONTROLLER(model.className) else {
            
            
            return
        }
        controller.title = model.title
        self.navigationController?.pushViewController(controller, animated: true)
        
        
    }
    
    
}

