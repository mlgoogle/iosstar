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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func initcustomer(){
        delegate = self

        let storyboardNames = ["Home","Market","Deal","Exchange","User"]
        let titles = ["首页","行情","交易","分答","个人中心"]
        for (index, name) in storyboardNames.enumerated() {
            let storyboard = UIStoryboard.init(name: name, bundle: nil)
            let controller = storyboard.instantiateInitialViewController()
            controller?.tabBarItem.title = titles[index]
            controller?.tabBarItem.image = UIImage.init(named: "\(storyboardNames[index])UnSelect")?.withRenderingMode(.alwaysOriginal)
            controller?.tabBarItem.selectedImage = UIImage.init(named: "\(storyboardNames[index])Select")?.withRenderingMode(.alwaysOriginal)
            controller?.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.red], for: .selected)
            addChildViewController(controller!)
        }
        

    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController){
        
        if tabBarController.selectedIndex == 1{
            
            let storyboard = UIStoryboard.init(name: "Login", bundle: nil)
            let controller = storyboard.instantiateInitialViewController()
            controller?.modalPresentationStyle = .custom
//            controller?.modalTransitionStyle = .coverVertical
            //            let nav = BaseNavigationController.init(rootViewController: controller)
            controller?.modalTransitionStyle = .crossDissolve
            present(controller!, animated: true, completion: nil)
        }
    }

    

}
