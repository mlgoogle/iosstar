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
        
        NotificationCenter.default.addObserver(self, selector: #selector(gethelp), name: Notification.Name.init(rawValue: AppConst.NoticeKey.frozeUser.rawValue), object: nil)
        
        
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
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
        

      
        
        let barItem : UIBarButtonItem = UIBarButtonItem.init(customView: btn)

        btn.frame = CGRect.init(x: 0, y: 13, width: 9, height: 17)
        let view = UIView(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
       
        view.addSubview(btn)
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(popself))
        view.addGestureRecognizer(tapGes)
    

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

