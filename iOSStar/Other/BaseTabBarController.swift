//
//  BaseTabBarController.swift
//  iosblackcard
//
//  Created by J-bb on 17/4/14.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController ,UITabBarControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initcustomer()
        
    }

    func initcustomer(){
    
        let storyboardNames = ["Home","Deal","User"]
        let titles = ["首页","交易","个人中心"]
        for (index, name) in storyboardNames.enumerated() {
            let storyboard = UIStoryboard.init(name: name, bundle: nil)
            let controller = storyboard.instantiateInitialViewController()
            controller?.tabBarItem.title = titles[index]
            controller?.tabBarItem.image = UIImage.init(named: "\(storyboardNames[index])UnSelect")?.withRenderingMode(.alwaysOriginal)
            controller?.tabBarItem.selectedImage = UIImage.init(named: "\(storyboardNames[index])Select")?.withRenderingMode(.alwaysOriginal)
//            controller?.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.init(rgbHex: 0x666666)], for: .normal)
            controller?.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.red], for: .selected)
            addChildViewController(controller!)
            
            delegate = self
            
            
            
        }
        

    }
    
    func setViewControllers()  {

        let vcNameArray = ["ViewController",
                           "ViewController",
//                           "ClubViewController",
//                           "PrivateAdvisoryViewController",
                           "ViewController",
                           "ViewController"]
        let titlesArray = ["黑卡",
                           "部落",
//                           "俱乐部",
//                           "私董会",
                           "管家",
                           "我的"]
        var vcArray = [UIViewController]()
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String;
        for index in 0...vcNameArray.count - 1 {
            let name = namespace + "." + vcNameArray[index]
            let cls = NSClassFromString(name) as? UIViewController.Type
            guard cls != nil else {
                return
            }
            let vc = cls!.init()
            let item = UITabBarItem(title: titlesArray[index], image: nil, tag: 1000+index)
            if vcNameArray[index] == "BlackCardViewController" {
                vc.tabBarItem = item
                vcArray.append(vc)
            } else {
                let nc = BaseNavigationController(rootViewController: vc)
                nc.tabBarItem = item
                vcArray.append(nc)
            }
        }
        viewControllers = vcArray
    }
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
//        let registVC = LoginVC()
//        
//        let vc =  BaseNavigationController.init(rootViewController: registVC)
//        present(vc, animated: true, completion: nil)
    }
}
