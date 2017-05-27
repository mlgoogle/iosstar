//
//  BaseNavigationController.swift
//  wp
//
//  Created by 木柳 on 2016/12/17.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController,UINavigationControllerDelegate ,UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.hideBottomHairline()
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor(hexString: AppConst.Color.main)];
        interactivePopGestureRecognizer?.isEnabled = true
        interactivePopGestureRecognizer?.delegate = self
        navigationBar.barTintColor = UIColor.white
        navigationBar.isTranslucent = false
        
    }
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    override func awakeFromNib() {
        
    }
    //MARK: 重新写左面的导航
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        super.pushViewController(viewController, animated: true)

        let btn : UIButton = UIButton.init(type: UIButtonType.custom)
        
        btn.setTitle("", for: UIControlState.normal)
        
        btn.setBackgroundImage(UIImage.init(named: "back"), for: UIControlState.normal )
    
        btn.addTarget(self, action: #selector(popself), for: UIControlEvents.touchUpInside)
        
        btn.frame = CGRect.init(x: -5, y: 0, width: 9, height: 17)
        
        let barItem : UIBarButtonItem = UIBarButtonItem.init(customView: btn)
        viewController.navigationItem.leftBarButtonItem = barItem
        interactivePopGestureRecognizer?.delegate = self
    }
    func popself(){
        if viewControllers.count > 1 {
             popViewController(animated: true)
        }else{
            dismissController()
        }
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if (viewControllers.count <= 1)
        {
            return false;
        }
        
        return true;
    }
   
}

