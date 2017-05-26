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

        let storyboardNames = ["News","Market","Exchange","User"]
        let titles = ["首页","行情","分答","个人中心"]
        for (index, name) in storyboardNames.enumerated() {
            let storyboard = UIStoryboard.init(name: name, bundle: nil)
            let controller = storyboard.instantiateInitialViewController()
            controller?.tabBarItem.title = titles[index]
            controller?.tabBarItem.image = UIImage.init(named: "\(storyboardNames[index])_unselect")?.withRenderingMode(.alwaysOriginal)
            controller?.tabBarItem.selectedImage = UIImage.init(named: "\(storyboardNames[index])_selected")?.withRenderingMode(.alwaysOriginal)
            
            controller?.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(hexString: AppConst.Color.titleColor)], for: .selected)
            addChildViewController(controller!)
        }
        

    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController){
        
        if tabBarController.selectedIndex == 2  || tabBarController.selectedIndex == 3{
            
          
            if  checkLogin(){
            
            }
           
        }
    }

    

}
